Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC59146D3D1
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Dec 2021 13:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbhLHM6y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Dec 2021 07:58:54 -0500
Received: from campbell-lange.net ([178.79.140.51]:48208 "EHLO
        campbell-lange.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbhLHM6y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Dec 2021 07:58:54 -0500
X-Greylist: delayed 907 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Dec 2021 07:58:54 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=campbell-lange.net; s=it; h=Content-Type:MIME-Version:Message-ID:Subject:To
        :From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=qK5LPo3SLXToHhlSTLNOnsRZrtU3JxpjtD42dgtFIlo=; b=JQOyYv3b9XEJonzyGxjRV9U4ij
        R1URW3TbI7WbHf5dhQmIlmzV63meCnXLFOLJtUBl34c/QukbwQrktXBkhfwmkrVNKYk2eaR884Ibm
        d5T/fJItWmAeAZ40PcrPYgGL1Na5UyleG8kC0l/ZKmYHApGs9zbuYv/TVNbdrBEFG/F0=;
Received: from [217.138.52.158] (helo=rory-t470s)
        by campbell-lange.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <rory@campbell-lange.net>)
        id 1muwF4-0002Ag-Gx
        for linux-btrfs@vger.kernel.org; Wed, 08 Dec 2021 12:40:14 +0000
Received: from rory by rory-t470s with local (Exim 4.94.2)
        (envelope-from <rory@rory-t470s>)
        id 1muwF4-000Ipn-3n
        for linux-btrfs@vger.kernel.org; Wed, 08 Dec 2021 12:40:14 +0000
Date:   Wed, 8 Dec 2021 12:40:14 +0000
From:   Rory Campbell-Lange <rory@campbell-lange.net>
To:     linux-btrfs@vger.kernel.org
Subject: trouble replacing second disk from pair
Message-ID: <YbCnrqxHJxYPATj9@campbell-lange.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We're trying to upgrade the disks in a btrfs pair, and I have successfully replaced one of them using btrfs replace. I presently have 

Label: 'btrfs-bkp'  uuid: da90602a-b98e-4f0b-959a-ce431ac0cdfa
	Total devices 2 FS bytes used 700.29GiB
	devid    2 size 2.73TiB used 1.73TiB path /dev/mapper/cdisk4
	devid    3 size 2.73TiB used 1.75TiB path /dev/mapper/cdisk2

I'd like to get rid of cdisk2 and replace it with a new disk.

However I'm unable to mount cdisk4 (the new disk) in degraded mode to allow me to similarly replace cdisk2 as I previously did for cdisk3. Is this because some of the data in only on cdisk2? If so I'd be grateful to 
know how to ensure the two disks have the same data and to allow cdisk2 to be replaced.

Regards
Rory

# btrfs filesystem usage /bkp

Overall:
    Device size:		   5.46TiB
    Device allocated:		   3.49TiB
    Device unallocated:		   1.97TiB
    Device missing:		     0.00B
    Used:			   1.37TiB
    Free (estimated):		   2.04TiB	(min: 2.04TiB)
    Data ratio:			      2.00
    Metadata ratio:		      1.91
    Global reserve:		 512.00MiB	(used: 0.00B)

Data,single: Size:1.00GiB, Used:1.00MiB
   /dev/mapper/cdisk2	   1.00GiB

Data,RAID1: Size:1.73TiB, Used:691.24GiB
   /dev/mapper/cdisk2	   1.73TiB
   /dev/mapper/cdisk4	   1.73TiB

Data,DUP: Size:8.00GiB, Used:7.30GiB
   /dev/mapper/cdisk2	  16.00GiB

Metadata,single: Size:1.00GiB, Used:0.00B
   /dev/mapper/cdisk2	   1.00GiB

Metadata,RAID1: Size:9.00GiB, Used:1.75GiB
   /dev/mapper/cdisk2	   9.00GiB
   /dev/mapper/cdisk4	   9.00GiB

Metadata,DUP: Size:1.00GiB, Used:10.03MiB
   /dev/mapper/cdisk2	   2.00GiB

System,single: Size:32.00MiB, Used:224.00KiB
   /dev/mapper/cdisk2	  32.00MiB

System,RAID1: Size:32.00MiB, Used:192.00KiB
   /dev/mapper/cdisk2	  32.00MiB
   /dev/mapper/cdisk4	  32.00MiB

System,DUP: Size:32.00MiB, Used:0.00B
   /dev/mapper/cdisk2	  64.00MiB

Unallocated:
   /dev/mapper/cdisk2	 998.39GiB
   /dev/mapper/cdisk4	1018.49GiB


