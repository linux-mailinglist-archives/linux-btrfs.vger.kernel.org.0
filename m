Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92605534C51
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 May 2022 11:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235818AbiEZJKL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 May 2022 05:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbiEZJKJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 May 2022 05:10:09 -0400
X-Greylist: delayed 189 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 26 May 2022 02:10:07 PDT
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67210C5E74
        for <linux-btrfs@vger.kernel.org>; Thu, 26 May 2022 02:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=dirtcellar.net; s=ds202112; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
        Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=bLZNz28GmlekpmUq3aDOxO39njRLo+fkf573rqUKrXI=; b=C9mfH2Pw082YFBReb3rExe7kxq
        MVsObjRkjg7fCoJriWCTVlzZuhWeKS7NS8VugE6MmsXUPP/mebFcaPRVaW9mAVjQYojbXZJVcgGFz
        1BzcQDNpEds2HqSqIEajSPhu27LKk5LOENGLZ5ExKltQMQ+SINhlYuns8jPTE8p48ay212QmfBFiF
        x8hwUL45uHyxsd/yTNPLliBw/c4UyxY1H0ZDTyzwbDQ92lTUnLTF8XaCEVqqaVO6Kh0SWYWxJXMbz
        FNUVuX2dQJ8WseX9jm+uXeYcBsDU3qn8sn3il8p9GV/WT1CJTH4sw/euMnp9AYhyrJYCeRW7kjXzp
        /X3Oj4Qw==;
Received: from 254.79-160-170.customer.lyse.net ([79.160.170.254]:58416 helo=[10.0.0.41])
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <waxhead@dirtcellar.net>)
        id 1nu9SK-0008NP-4u; Thu, 26 May 2022 11:06:56 +0200
Reply-To: waxhead@dirtcellar.net
Subject: Re: [PATCH DRAFT] btrfs: RAID56J journal on-disk format draft
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <f6679e0b681f9b1a74dfccbe05dcb5b6eb0878f6.1653372729.git.wqu@suse.com>
 <20220524170234.GW18596@twin.jikos.cz> <Yo3wRJO/h+Cx47bw@infradead.org>
 <bd6ac4d4-41bf-f662-e7c0-7841895554a6@gmx.com>
 <Yo32VXWO81PlccWH@infradead.org>
 <b8cbcac2-7e8b-e0fd-67a9-8a782e0afe23@gmx.com>
From:   waxhead <waxhead@dirtcellar.net>
Message-ID: <9d1e2fc6-9ee6-68f8-bda8-8dd7e59e74e5@dirtcellar.net>
Date:   Thu, 26 May 2022 11:06:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 SeaMonkey/2.53.12
MIME-Version: 1.0
In-Reply-To: <b8cbcac2-7e8b-e0fd-67a9-8a782e0afe23@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Qu Wenruo wrote:
> 
> 
> On 2022/5/25 17:26, Christoph Hellwig wrote:
>> On Wed, May 25, 2022 at 05:13:11PM +0800, Qu Wenruo wrote:
>>> The problem is, we can have partial write for RAID56, no matter if we
>>> use NODATACOW or not.
>>>
>>> For example, we have a very typical 3 disks RAID5:
>>>
>>>     0    32K    64K
>>> Disk 1  |DDDDDDD|       |
>>> Disk 2  |ddddddd|ddddddd|
>>> Disk 3  |PPPPPPP|PPPPPPP|
>>>
>>>
>>> D = old data, it's there for a while.
>>> d = new data, we want to write.
>>
>> Oh.  I keep forgetting that the striping is entirely on the physіcal
>> block basis and not logic block basis.  Which makes the whole idea
>> of btrfs integrated raid5/6 not all that useful compared to just using
>> mdraid :(
> 
> Yep, that's why I have to go the old journal way.
> 
> But you may want to explore the super awesome idea of raid stripe tree
> from Johannes.
> 
> The idea is we introduce a new layer of logical addr -> internal mapping
> -> physical addr.
> By that, we get rid of the strict physical address requirement.
> 
> And when we update the new stripe, we just insert two new mapping for
> (dddd), and two new mapping for the new (PPPPP).
> 
> If power loss happen, we still see the old internal mapping, and can get
> the correct recovery.
> 
> But it still seems to have a lot of things to resolve for now.
> 
> Thanks,
> Qu

I am just a humble BTRFS user and while I think the journaled approach 
sounds superinteresting I believe that the stripe tree sounds like the 
better solution in the long run.

Is it really such a good idea to add a (potentially temporary) journaled 
raid mode if the stripe tree version really is better? What about Josef 
Bacik's extent tree v2 ? Would that fit better with the stripe tree / 
would it cause problems with the journaled mode?

As a regular user I think that adding another raid56 mode may be 
confusing, especially for people that do not understand how things work 
(which absolutely sometimes includes me too), Quite some BTRFS use is 
also done outside the datacenter, and it is regular joe and co. that 
complains the most when they screw up, which to some extent prevents 
adoption on non-stellar hardware which again would/could lead to 
bugreorts and a better filesystem in the long run. So therefore:

If the standard raid56 mode is unstable and discouraged to use, would it 
not be better to sneakily drop that once and for all e.g. just make it 
so that new filesystems created with raid56 automatically uses the new 
(and better) raid56j mode? Effectively preventing users from making 
filesystems with the "bad" raid56 after a certain btrfs-progs version?

This way the raid56 code would seem to be fixed albeit getting slower 
(as I understand it), but the number of configurations available is not 
overwhelming for us regular people.

PS! I understand that I sound like I am not to keen on the new raid56j 
mode which is sort of true, but that does not mean that I am ungrateful 
for it :)
