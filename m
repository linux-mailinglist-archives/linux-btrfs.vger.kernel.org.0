Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6A3743166
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jun 2023 02:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjF3AAK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Jun 2023 20:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjF3AAI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Jun 2023 20:00:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B3B2972
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Jun 2023 17:00:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD01E6159B
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Jun 2023 00:00:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B82BBC433C0;
        Fri, 30 Jun 2023 00:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688083207;
        bh=iTjHZ+ZGqutPz6YhgSckE+y2O72B/pY4NmXrXrWdqg0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=iRduDJ76Crd8OulxVJpdrYf6ajRLDHY9zaFjAUQ6rmuNJUDQJReObvftQvzYxni0h
         5j2kX64nTq/sGKGsTr0aA/4/dk/iNuxHMWI51F+madBah3+PuP3aRpBXqOurMWX7tu
         0GkSK4rf+Gg9U8ZxFFIZiuLJglPhC042VhqLD0h02Z0U0cLzPzkvlklNIA52ayr/2r
         RW6Xo6893IHoUdezs5eIdusiSnKLxWsg99ZnphxS7lK4RG1a/6K3OObV9scVCpSC3i
         5ZUPLmFvJNt9PP4Eet8FtUt5q+6qiZ7p32rrc9lsU/GmlS3Tz7OtwKoO271gNKmYgX
         RiayYKByjnPgQ==
Message-ID: <2498b51e-5aed-348e-8c87-a62482a1fbae@kernel.org>
Date:   Fri, 30 Jun 2023 09:00:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] btrfs: zoned: do not enable async discard
Content-Language: en-US
To:     Roman Mamedov <rm@romanrm.net>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
References: <e22f5f69d881de1ec0e381f1be6bfe61b822c064.1688027756.git.naohiro.aota@wdc.com>
 <e803b649-299b-05b6-6528-06437548e974@kernel.org>
 <20230629162518.164ca443@nvm>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230629162518.164ca443@nvm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 6/29/23 20:25, Roman Mamedov wrote:
> On Thu, 29 Jun 2023 18:15:05 +0900
> Damien Le Moal <dlemoal@kernel.org> wrote:
> 
>>> +	if (btrfs_test_opt(info, DISCARD_ASYNC)) {
>>> +		btrfs_warn(info, "zoned: disabling async discard as it is not supported");
>>
>> The "not supported" mention here kind of imply that we are not finished with
>> this support yet. So may be a simple: "zoned: ignoring async discard" would
>> suffice ?
> 
> IMO "not supported" does not imply "not supported yet". To me the message
> reads more like "not supported by definition" (of zoned), i.e. no
> misunderstanding.

Yeah... I guess it can be understood both ways. I generally prefer to not
"scare" (again, that is very subjective) the user with messages saying "not
supported" if in fact it is not about support but about the feature not being
needed or not appropriate for the setup. But no strong feeling about all this.
Let's keep the message as is. My RB tag stands.

-- 
Damien Le Moal
Western Digital Research

