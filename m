Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C14A8ED6B
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Aug 2019 15:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732627AbfHONwx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Aug 2019 09:52:53 -0400
Received: from resqmta-po-01v.sys.comcast.net ([96.114.154.160]:48506 "EHLO
        resqmta-po-01v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732426AbfHONwx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Aug 2019 09:52:53 -0400
Received: from resomta-po-20v.sys.comcast.net ([96.114.154.244])
        by resqmta-po-01v.sys.comcast.net with ESMTP
        id yFk6hhO77pdw9yGBQhgH8G; Thu, 15 Aug 2019 13:52:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=20190202a; t=1565877172;
        bh=9GHNH99Nso8hhIAcIkTr4ozYJREq1hKA781y0M35EIk=;
        h=Received:Received:Received:Received:Date:From:To:Subject:
         Message-ID:Reply-To:MIME-Version:Content-Type;
        b=JSodLHeMPp0sOiXagKQyPSXgckx6NIfbR4qraCsSAzO4/UdRH1kiA3gOZBpqeCn/k
         sHwezpHIG1wL7v44IRfAXlZ0d5V/ynjc776K5QYfNSkKLDvvdbNTMtQFE6aKcm0p1N
         U7djcp9Rh1FqmPpB6k8j8K14QfZOZBaBq5gh2Mwh8ZJOrD8OHXZ2pIL8iOjptqfDKx
         ftrniqyn8Ah0QGF9FI6+laBa541m4+/jb9xhD2G/gZ4BqZvbmEgQHQDaPUI0RjghsB
         Zd/A/8Lm94RGqKk34Uuth1S5SKMIiyMoFFotQbtTt3i1nmtFs2+QZ3HR5v5d2pYJIy
         23Qm1Bjf1IbfQ==
Received: from beta.localdomain ([73.209.109.78])
        by resomta-po-20v.sys.comcast.net with ESMTPA
        id yGBPhE3DGDsRxyGBQhGmKt; Thu, 15 Aug 2019 13:52:52 +0000
X-Xfinity-VAAS: gggruggvucftvghtrhhoucdtuddrgeduvddrudefuddgieelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuvehomhgtrghsthdqtfgvshhipdfqfgfvpdfpqffurfetoffkrfenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkrhhfgggtuggjvggfsehttdertddtredvnecuhfhrohhmpefvihhmucghrghlsggvrhhguceothifrghlsggvrhhgsegtohhmtggrshhtrdhnvghtqeenucfkphepjeefrddvtdelrddutdelrdejkeenucfrrghrrghmpehhvghlohepsggvthgrrdhlohgtrghlughomhgrihhnpdhinhgvthepjeefrddvtdelrddutdelrdejkedpmhgrihhlfhhrohhmpehtfigrlhgsvghrghestghomhgtrghsthdrnhgvthdprhgtphhtthhopehquhifvghnrhhuohdrsghtrhhfshesghhmgidrtghomhdprhgtphhtthhopehtfigrlhgsvghrghestghomhgtrghsthdrnhgvthdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-Xfinity-VMeta: sc=0;st=legit
Received: from calvin.localdomain ([10.0.0.8])
        by beta.localdomain with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <twalberg@comcast.net>)
        id 1hyGBP-0007HA-Eo; Thu, 15 Aug 2019 08:52:51 -0500
Received: from tew by calvin.localdomain with local (Exim 4.84_2)
        (envelope-from <tew@calvin.localdomain>)
        id 1hyGBP-0003ZH-A1; Thu, 15 Aug 2019 08:52:51 -0500
Date:   Thu, 15 Aug 2019 08:52:51 -0500
From:   Tim Walberg <twalberg@comcast.net>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Tim Walberg <twalberg@comcast.net>, linux-btrfs@vger.kernel.org
Subject: Re: recovering from "parent transid verify failed"
Message-ID: <20190815135251.GC2731@comcast.net>
Reply-To: Tim Walberg <twalberg@comcast.net>
References: <20190814183213.GA2731@comcast.net>
 <4be5086f-61e7-a108-8036-da7d7a5d5c11@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4be5086f-61e7-a108-8036-da7d7a5d5c11@gmx.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Had to wait for 'btrfs recover' to finish before I proceed farther.

Kernel is 4.19.45, tools are 4.19.1

File system is a 3-disk RAID10 with WD3003FZEX (WD Black 3TB)

Output from attempting to mount:

# mount -o ro,usebackuproot /dev/sdc1 /mnt
mount: wrong fs type, bad option, bad superblock on /dev/sdc1,
       missing codepage or helper program, or other error

       In some cases useful info is found in syslog - try
       dmesg | tail or so.

Kernel messages from the mount attempt:

[Thu Aug 15 08:47:42 2019] BTRFS info (device sdc1): trying to use backup root at mount time
[Thu Aug 15 08:47:42 2019] BTRFS info (device sdc1): disk space caching is enabled
[Thu Aug 15 08:47:42 2019] BTRFS info (device sdc1): has skinny extents
[Thu Aug 15 08:47:42 2019] BTRFS error (device sdc1): parent transid verify failed on 229846466560 wanted 49749 found 49750
[Thu Aug 15 08:47:42 2019] BTRFS error (device sdc1): parent transid verify failed on 229846466560 wanted 49749 found 49750
[Thu Aug 15 08:47:42 2019] BTRFS error (device sdc1): failed to read block groups: -5
[Thu Aug 15 08:47:42 2019] BTRFS error (device sdc1): open_ctree failed

Output from 'btrfs check -p /dev/sdc1':

# btrfs check -p /dev/sdc1
Opening filesystem to check...
parent transid verify failed on 229846466560 wanted 49749 found 49750
Ignoring transid failure
ERROR: child eb corrupted: parent bytenr=229845336064 item=0 parent level=1 child level=2
ERROR: cannot open file system




On 08/15/2019 10:35 +0800, Qu Wenruo wrote:
>>	
>>	
>>	On 2019/8/15 ??????2:32, Tim Walberg wrote:
>>	> Most of the recommendations I've found online deal with when "wanted" is
>>	> greater than "found", which, if I understand correctly means that one or
>>	> more transactions were interrupted/lost before fully committed.
>>	
>>	No matter what the case is, a proper transaction shouldn't have any tree
>>	block overwritten.
>>	
>>	That means, either the FLUSH/FUA of the hardware/lower block layer is
>>	screwed up, or the COW of tree block is already screwed up.
>>	
>>	> 
>>	> Are the recommendations for recovery the same if the system is reporting a
>>	> "wanted" that is less than "found"?
>>	> 
>>	The salvage is no difference than any transid mismatch, no matter if
>>	it's larger or smaller.
>>	
>>	It depends on the tree block.
>>	
>>	Please provide full dmesg output and btrfs check for further advice.
>>	
>>	Thanks,
>>	Qu
>>	




-- 
+----------------------+
| Tim Walberg          |
| 830 Carriage Dr.     |
| Algonquin, IL 60102  |
| twalberg@comcast.net |
+----------------------+
