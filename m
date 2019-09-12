Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45989B15E7
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2019 23:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbfILVep (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Sep 2019 17:34:45 -0400
Received: from server53-3.web-hosting.com ([198.54.126.113]:41885 "EHLO
        server53-3.web-hosting.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728502AbfILVep (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Sep 2019 17:34:45 -0400
X-Greylist: delayed 677 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Sep 2019 17:34:44 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=zedlx.com;
         s=default; h=MIME-Version:Content-Type:In-Reply-To:References:Subject:Cc:To:
        From:Message-ID:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=20g7/ZM9Gn2yfRBDX6dN/ZnbeBbUtIMRlrYia6XVwgM=; b=t/lj5g+TsijkgYAmKSculkSqC6
        xeZa2rdKFa/CZLQbFdYTOtpxaZnINJkJB6sH9s3/8nPuuk3seKzdPHxQDIAta14JR/JoKbkBLD2kL
        VwHzbUt8WgY0LTMtg/ef2Fca0yolWwl5nHqUkId/sgCxguZkrpMHXoT+1Ep9iDdvZf2S7tLazYZ6q
        smIVTfBOEUgsCIeFTuOdz41rxy+JHYph0qwtbfNi2cAnU65KXUv+Unr2Ej7O51ploz2ymCrb6CBlj
        Jp/jaj2d/bqMp/R4rT4UUCNfH+sg6+QALrl5pwq7jwozHVLKFjhJrGPDDIcRDRntztQC41t7hEcs0
        CKrP53NA==;
Received: from [::1] (port=50914 helo=server53.web-hosting.com)
        by server53.web-hosting.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <general-zed@zedlx.com>)
        id 1i8Wjg-003QwY-Gf; Thu, 12 Sep 2019 17:34:44 -0400
Received: from [95.178.242.92] ([95.178.242.92]) by server53.web-hosting.com
 (Horde Framework) with HTTPS; Thu, 12 Sep 2019 17:34:40 -0400
Date:   Thu, 12 Sep 2019 17:34:40 -0400
Message-ID: <20190912173440.Horde.WmxNqLlw7nsFNa-Ux9TTgbz@server53.web-hosting.com>
From:   General Zed <general-zed@zedlx.com>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     "Austin S. Hemmelgarn" <ahferroin7@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Feature requests: online backup - defrag - change RAID level
References: <20190908225508.Horde.51Idygc4ykmhqRn316eLdRO@server53.web-hosting.com>
 <5e6a9092-b9f9-58d2-d638-9e165d398747@gmx.com>
 <20190909072518.Horde.c4SobsfDkO6FUtKo3e_kKu0@server53.web-hosting.com>
 <fb80b97a-9bcd-5d13-0026-63e11e1a06b5@gmx.com>
 <c4f05241-77d4-3ae4-9773-795351a26a8e@cobb.uk.net>
 <20190909152625.Horde.fICzOssZXCnCZS2vVHBK-sn@server53.web-hosting.com>
 <fc81fcf2-f8e9-1a08-52f8-136503e40494@gmail.com>
 <20190910193221.Horde.HYrKYqNVgQ10jshWWA1Gxxu@server53.web-hosting.com>
 <d958659e-6dc0-fa0a-7da9-2d88df4588f5@gmail.com>
 <20190911132053.Horde._wJd24LqxxXx9ujl2r5i7PQ@server53.web-hosting.com>
 <c8da6684-6c16-fc80-8e10-1afc1871d512@gmail.com>
 <20190911173725.Horde.aRGy9hKzg3scN15icIxdbco@server53.web-hosting.com>
 <81f4870e-3ee9-7780-13aa-918d24ca10d8@gmail.com>
 <20190912151841.Horde.-wdqt-14W0sbNwBxzhWVB6B@server53.web-hosting.com>
 <CAJCQCtQbRCdVOknOo6vusG+fQu1SB3=h8r=qDcZHUu+EFe480A@mail.gmail.com>
In-Reply-To: <CAJCQCtQbRCdVOknOo6vusG+fQu1SB3=h8r=qDcZHUu+EFe480A@mail.gmail.com>
User-Agent: Horde Application Framework 5
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server53.web-hosting.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - zedlx.com
X-Get-Message-Sender-Via: server53.web-hosting.com: authenticated_id: zedlryqc/from_h
X-Authenticated-Sender: server53.web-hosting.com: general-zed@zedlx.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-From-Rewrite: unmodified, already matched
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Quoting Chris Murphy <lists@colorremedies.com>:

> On Thu, Sep 12, 2019 at 1:18 PM <webmaster@zedlx.com> wrote:
>>
>> It is normal and common for defrag operation to use some disk space
>> while it is running. I estimate that a reasonable limit would be to
>> use up to 1% of total partition size. So, if a partition size is 100
>> GB, the defrag can use 1 GB. Lets call this "defrag operation space".
>
> The simplest case of a file with no shared extents, the minimum free
> space should be set to the potential maximum rewrite of the file, i.e.
> 100% of the file size. Since Btrfs is COW, the entire operation must
> succeed or fail, no possibility of an ambiguous in between state, and
> this does apply to defragment.
>
> So if you're defragging a 10GiB file, you need 10GiB minimum free
> space to COW those extents to a new, mostly contiguous, set of exents,

False.

You can defragment just 1 GB of that file, and then just write out to  
disk (in new extents) an entire new version of b-trees.
Of course, you don't really need to do all that, as usually only a  
small part of the b-trees need to be updated.

The only problem that there can arise is if the original file is  
entirely one 10 GB extent. In that case, that extent should be split  
into smaller parts. If btrfs cannot do that splitting, mostly (but not  
entirely) in-place, than it is a fundamentally flawed design, but I  
reckon that is not the case. You would have to be really stupid to  
design a filesystem that way, if it is even possible to design a  
filesystem with such property.


