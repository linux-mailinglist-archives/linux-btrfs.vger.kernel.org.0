Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F150F617ADD
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Nov 2022 11:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbiKCKeG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Nov 2022 06:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiKCKeE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Nov 2022 06:34:04 -0400
X-Greylist: delayed 3685 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 03 Nov 2022 03:34:01 PDT
Received: from smtp41.i.mail.ru (smtp41.i.mail.ru [94.100.177.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3303101FC
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Nov 2022 03:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:To:From:Subject:MIME-Version:Date:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=FnD5Sgd1eP8QskTgGDc4xZRvia4jb9IqPEdjFUxAvwU=;
        t=1667471641;x=1667561641; 
        b=LEYP2eUP4g8RHoCBAhb7dVviymQPBg+F2UC0F5u3ng2lbRH5H1Tp9oMu2GUYihS1GMneOpQxLlm/leZAKdYfGH02qFQMw/36UPKOTkr1rPu36PxoBSlW4neU31r7D2w+LPvGVO/IaEKg/3KILmPAIKEqrdbMSEd2NAnaRN6/T/5iQNW06O5BS/6O8TcPjwc4ov2LlPfWlZ+7HFruBs2yaBGfzoDtH2sKqWsvmcWegl8JC8IMplAe2+o9nnWQXPoOAnViaRoz+jZljnij0qzY+jfG8OX5imgG4cReqRjxh7ssLvyg0FQMhlbB4KopKK/Vg7ZhpqUtenTWfzNzalv/AA==;
Received: by smtp41.i.mail.ru with esmtpa (envelope-from <Nemcev_Aleksey@inbox.ru>)
        id 1oqXXq-0007wN-4n
        for linux-btrfs@vger.kernel.org; Thu, 03 Nov 2022 13:33:59 +0300
Message-ID: <e252c2c3-408e-f19d-9423-1d9d92f5e2f2@inbox.ru>
Date:   Thu, 3 Nov 2022 13:33:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: ERROR: invalid size for attribute, expected = 4, got = 8 on
 subvolume send
From:   Nemcev Aleksey <Nemcev_Aleksey@inbox.ru>
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <6cb11fa5-c60d-e65b-0295-301a694e66ad@inbox.ru>
Content-Language: en-US
In-Reply-To: <6cb11fa5-c60d-e65b-0295-301a694e66ad@inbox.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp41.i.mail.ru; auth=pass smtp.auth=Nemcev_Aleksey@inbox.ru smtp.mailfrom=Nemcev_Aleksey@inbox.ru
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD967121363E257EE6D5A169EEB5D12808189D3C2153EF712E700894C459B0CD1B9D4C166A0FB081550B3A93398749D150A5FD696C865C337140B379AF87BB1B6F5
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7922D113DFDC6D5A3EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006378A9F193E39E334918638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D83E3B83C8269644C7C1FAE7771CC88B996F9789CCF6C18C3F8528715B7D10C86878DA827A17800CE7CCEADDFEB1F9DC069FA2833FD35BB23D9E625A9149C048EE1E561CDFBCA1751F2CC0D3CB04F14752D2E47CDBA5A96583BD4B6F7A4D31EC0BC014FD901B82EE079FA2833FD35BB23D27C277FBC8AE2E8B85F16315563D62F5A471835C12D1D977C4224003CC836476EB9C4185024447017B076A6E789B0E975F5C1EE8F4F765FC8838AAAD75ACD35E3AA81AA40904B5D9CF19DD082D7633A078D18283394535A93AA81AA40904B5D98AA50765F7900637EDDE4FD3F6DF783AD81D268191BDAD3D3666184CF4C3C14F3FC91FA280E0CE3D1A620F70A64A45A98AA50765F79006372E808ACE2090B5E1725E5C173C3A84C3C5EA940A35A165FF2DBA43225CD8A89F8361DED9BCED162D35872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D34A246DFF68F0EE19E6F3308A1ED3E261F688FFBC1301D2F92FCCAA30F0EAE8E9AC8E574E72D9957531D7E09C32AA3244CAB345AAEF69B6A4B739C05D710EC17584DBEAD0ED6C55A803EB3F6AD6EA9203E
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojYfCECMrgGhT8yZpJOsodOw==
X-Mailru-Sender: 6F30CE3AAFA23F85D1B9D8D23F7101C4F881B1F90B9F83FD043578EDD59227C7722023C4CA3CDBAEB5D628A7EF4494575C5F6E3C72ABB53BB0D9B300F142F0238EAA47040EB6BC244E4EA347F45ED768B49EAA7E57EF395FB4A721A3011E896F
X-Mras: Ok
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

03.11.2022 12:32, Nemcev Aleksey пишет:
> Hello.
>
>  I'm using Btrfs with zstd compression (subvolume property 
> compression=zstd) on the PC and on the backup drive and running as a 
> daemon the `bees` (on-demand deduplication tool) on the PC.
>
>  I'm using btrfs send | btrfs receive to send incremental snapshots of 
> PC subvolumes and receive them to the backup drive.
>  Sometimes receive fails with ERROR: invalid size for attribute, 
> expected = 4, got = 8 or ERROR: invalid size for attribute, expected = 
> 8, got = 4
>
>  Why does this error happen?
>  How can I debug this error? At least how to get the problem file name?
>  Is that attribute an internal Btrfs-specific thing or something 
> generic like xattr attribute or file attribute (lsattr/chattr)?
>  Is it possible to resolve this error without removing the subvolume 
> and snapshot on the backup drive and resending the complete subvolume 
> again?
>
>  Thank you.

UPD:

It seems that the --compressed-data option on btrfs-send was the issue, 
when I removed it, and now btrfs-receive works fine on the same PC and 
backup drive.
This is not an issue for me, as I'm using bash pipe to connect 
btrfs-send and btrfs-receive (but this wastes CPU time for decompression 
and recompression data during send/receive).
But this can be an issue for anyone with a slow channel between send and 
receive sides.
