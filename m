Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7CC76A742
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Aug 2023 05:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjHADAC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Jul 2023 23:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjHADAB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Jul 2023 23:00:01 -0400
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1385C1981
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 20:00:00 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 15B4B8355E;
        Mon, 31 Jul 2023 22:59:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1690858799; bh=HTK1HuMPUGMIRR4fBIj7edKiSftA0M0WiuvfNDKwCX4=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=PNw5X5xD3otEryhIyngRmzw7b4TFvL8gKmko/WaVt/akP0OjxXY5Rb5kOqZU9nP5G
         JaDlbgZdmP8vQfCw2lJsp7kOxTq0yM8knMrREMG472kLc4cQnGPQwTUHPNIC1xhha3
         tB9AjbJ4MLjNxU+1IEnKJYAlFKD2eZU84IhJvHU/9hacYxU3jQ1u8vMYZ+B+U2gF0Z
         oe1JGp6BpE6LSae7UHqVto79VunRaP++XAofu0pbE05BZEMoetKoRvHJWNWf1SmtR/
         34u/y8xGBmZH4JSAF1BUOgwJoQki2++EJIYG7fDad2TnB4Mi3IIKR5VeO0hvlFc2Eo
         BaEBGUA2C/Agg==
Message-ID: <777e288c-f918-cb15-620d-3c3fd770d240@dorminy.me>
Date:   Mon, 31 Jul 2023 22:59:57 -0400
MIME-Version: 1.0
Subject: Re: [PATCH RFC] Btrfs: only subtract from len_to_oe_boundary when it
 is tracking an extent
Content-Language: en-US
To:     Chris Mason <clm@meta.com>, Chris Mason <clm@fb.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com,
        josef@toxicpanda.com, hch@lst.de
References: <20230730190226.4001117-1-clm@fb.com>
 <d83bd29b-9744-cf48-c5a5-24668a6ec4f5@dorminy.me>
 <0375397a-dd5c-4b3b-53b7-1d2da33ef845@meta.com>
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <0375397a-dd5c-4b3b-53b7-1d2da33ef845@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 7/31/23 15:22, Chris Mason wrote:
> On 7/30/23 4:27 PM, Sweet Tea Dorminy wrote:
>>
>>> +        /*
>>> +         * len_to_oe_boundary defaults to U32_MAX, which isn't page or
>>> +         * sector aligned.  So, we don't really want to do math on
>>> +         * len_to_oe_boundary unless it has been intentionally set by
>>> +         * alloc_new_bio().  If we decrement here, we'll potentially
>>> +         * end up sending down an unaligned bio once we get close to
>>> +         * zero.
>>> +         */
>>
>> As I understand it, the important part is: nothing should use
>> len_to_oe_boundary unless there's an actual oe boundary, U32_MAX is just
>> a placeholder to convey the information that there's no oe boundary.
>>
>> So maybe:
>> /*
>>   * len_to_oe_boundary being U32_MAX indicates that no ordered extent was
>>   * found by alloc_new_bio(), so there's no boundary.
>>   */
>>
>> I think talking about doing math on U32_MAX here obscures the main point.
>>
> 
> Jens wasn't surprised by the idea of a bio almost U32_MAX bytes long,
> but I needed a printk to convince myself it was really happening.
> Talking about alignment and seeing bios in the wild of these sizes helps
> anyone changing the code keep these corner cases in mind.
> 
> +/- the part where Christoph is deleting len_to_oe_boundary completely,
> and he'll drive this code up to a nice farm in the country where it can
> retire in the sunshine.
> 
> -chris

Sounds good.

Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
