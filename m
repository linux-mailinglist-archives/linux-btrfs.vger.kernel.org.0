Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF5B7687EA
	for <lists+linux-btrfs@lfdr.de>; Sun, 30 Jul 2023 22:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjG3U1p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 30 Jul 2023 16:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjG3U1o (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 30 Jul 2023 16:27:44 -0400
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFE5113
        for <linux-btrfs@vger.kernel.org>; Sun, 30 Jul 2023 13:27:42 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 3B0A580794;
        Sun, 30 Jul 2023 16:27:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1690748861; bh=ar4eZfpmaBx8qRr6zAbC8H9FUY97Dpl3i3Waz/KizO8=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=I3GFQ5ATCnPiZZ7KbxwoQ8U3iMdVGRnK8XdpgVkg3XGpPZ2y3Cft7ShJVq/EiJZkz
         4IE0Kfu8BEx/UefmBJt+zZ/NkbeuArCTUX1tIHCnIpYMeetMRForPN4/mzpv36K98s
         nHXFAKgZpil1KHrpmxVdZrT30fCCb0KuGrPXBwusgPU/u9Cof909hKaQ8iI0q/hWmf
         ew31HzU1nSHqDzCXOpQ9ywzGcUL50u1+vLQ/WbDmVr8cWWCkZhPDwNze2OSGnzcWgd
         9hV/5GD5anDIcU+eOTE/C2ZXb3M4hIjK/pDBkywY5sdVGh8Qd598pJafPa9hYUXqO7
         durcc6Jj8cqDA==
Message-ID: <d83bd29b-9744-cf48-c5a5-24668a6ec4f5@dorminy.me>
Date:   Sun, 30 Jul 2023 16:27:40 -0400
MIME-Version: 1.0
Subject: Re: [PATCH RFC] Btrfs: only subtract from len_to_oe_boundary when it
 is tracking an extent
To:     Chris Mason <clm@fb.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com, josef@toxicpanda.com, hch@lst.de
References: <20230730190226.4001117-1-clm@fb.com>
Content-Language: en-US
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <20230730190226.4001117-1-clm@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


> +		/*
> +		 * len_to_oe_boundary defaults to U32_MAX, which isn't page or
> +		 * sector aligned.  So, we don't really want to do math on
> +		 * len_to_oe_boundary unless it has been intentionally set by
> +		 * alloc_new_bio().  If we decrement here, we'll potentially
> +		 * end up sending down an unaligned bio once we get close to
> +		 * zero.
> +		 */

As I understand it, the important part is: nothing should use 
len_to_oe_boundary unless there's an actual oe boundary, U32_MAX is just 
a placeholder to convey the information that there's no oe boundary.

So maybe:
/*
  * len_to_oe_boundary being U32_MAX indicates that no ordered extent was
  * found by alloc_new_bio(), so there's no boundary.
  */

I think talking about doing math on U32_MAX here obscures the main point.

Otherwise the bug, and fix, looks good to me.
