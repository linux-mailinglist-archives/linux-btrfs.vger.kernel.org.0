Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06EB5274376
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Sep 2020 15:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgIVNts (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Sep 2020 09:49:48 -0400
Received: from mailrelay3-3.pub.mailoutpod1-cph3.one.com ([46.30.212.12]:23996
        "EHLO mailrelay3-3.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726473AbgIVNtr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Sep 2020 09:49:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lechevalier.se; s=20191106;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version:date:
         message-id:from:references:to:subject:from;
        bh=O/uMd1a9X1pttMwgLjT++HiEl2Pjj+FDCTlVIDGKfCs=;
        b=up4bh/6PEKQoflydw54bt9oeBxG+NP11gLJJGG+LR4aH0ARkC7liuHuy5kP0sXCtsFQc6upTPnSXe
         ZYYc6CVHnXe2FcwSS/6/W0MkYFktI7hOQs6rkuqremZXbcR0MfW0h4MmlQpGpR50uDwq1MC4lgBjBH
         cHbdVmSQ0j8BJrvtzNKH+zFfzfV10wPi13bzrJaxt73SBymxlgqleWWaJk36UUZfYJo1pFbDQf5Yd4
         xlOEsrhLUSZxEKOjUHoQbimxI42ffsCrLz2riHAJ5P5tVumWasxNH3oViNsxUuDcJG+eRySpQ0lu06
         zfsOLS4mi5NjF2RNU4ZB7EMFbTf8g9g==
X-HalOne-Cookie: 2e5b11af2cd89f12ff83e50b613da05dc3b01a88
X-HalOne-ID: 78a908d0-fcda-11ea-a7fd-d0431ea8bb03
Received: from [10.0.155.198] (unknown [98.128.186.115])
        by mailrelay3.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 78a908d0-fcda-11ea-a7fd-d0431ea8bb03;
        Tue, 22 Sep 2020 13:49:44 +0000 (UTC)
Subject: Re: Btrfs wiki lincese and GDPR notices?
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <b317b7cc-8810-57ea-b859-6bef7638a5c7@lechevalier.se>
 <20200921181834.GO6756@twin.jikos.cz>
From:   A L <mail@lechevalier.se>
Message-ID: <fe9dc70f-25fc-978d-eab8-c40d5e2105b0@lechevalier.se>
Date:   Tue, 22 Sep 2020 15:49:44 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200921181834.GO6756@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020-09-21 20:18, David Sterba wrote:
> Hi,
>
> On Sun, Sep 20, 2020 at 11:03:07AM +0200, A L wrote:
>> Under what license are the content and uploaded images and documents on
>> https://btrfs.wiki.kernel.org/
> I think nobody has asked this question until now, so I don't know.

No worries. I was curious because I had an idea to re-use some text and 
images on a personal blog.

I think it is common for MediaWiki platforms to be setup so that 
user-provided content is under the Creative Commons 
Attribution-ShareAlike Licence unless otherwise stated. For example an 
image might be uploaded with CC0 or some other license while the text is 
CC-BY-SA or GPL. For example, the XFS wiki ( https://xfs.wiki.kernel.org 
) is using this approach.

Perhaps it is worth considering adding this to the Btrfs wiki?

>> For example, file have no copyright or license information:
>> https://btrfs.wiki.kernel.org/index.php/File:Send_subvol_command.png
>> https://btrfs.wiki.kernel.org/index.php/File:Fs-tree.svg
>>
>> Currently the "Privacy Policy" and "About" pages are empty. There is
>> also no GDPR information.
> All the wikis fall under the Linux foundation policies regarding
> accounts, so the GDPR questions better be directed there
> (https://korg.docs.kernel.org/wiki.html,
> https://korg.docs.kernel.org/support.html).
Thanks for the links.  I note that in general, it seems that GDPR 
implementations, and especially GDPR info for FOSS is lacking in a many 
communities and projects. kernel.org does not have a GDPR notice, for 
example.
