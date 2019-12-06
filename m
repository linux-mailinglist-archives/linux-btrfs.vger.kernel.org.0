Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15383114A86
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 02:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbfLFBcZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Dec 2019 20:32:25 -0500
Received: from st43p00im-zteg10073401.me.com ([17.58.63.181]:56822 "EHLO
        st43p00im-zteg10073401.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725988AbfLFBcZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Dec 2019 20:32:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1575595944;
        bh=6wpNOJz4kHYCYOMoMzQSFLZrn5TIO14E1sYLsujP2U4=;
        h=Content-Type:Subject:From:Date:Message-Id:To;
        b=FajcT6gnyYJ41CYSafvcMWfbM+zW2XO2bc5eIEKWcdO90atTisi4GXRvMLgaLgEMF
         L+xVK2JkwqbmmN7ElacaM1mSxXbXjBTr3fu8hD0NSlaxZCIoqorojpgFcaw8dnoNzE
         KE6eGwQJWqdlPxXGcel02e0E0TShDVUHfnEvZAUytjbIiDwl9JM8JSWq3Uu9Zjx7/i
         ZMpvJjW5jVfyZ1DoW8jBOp3OpERsRaSRzFYFVLlPF4ZYihGp8ElYqud6FkNDRzBHII
         kES+Tco+5NHrq0l/raeRRNLjVMt/dy9zjw/nTQ2k43MueccgLLhiPseyA/+58vBgPY
         YSXL/oG2Pbchw==
Received: from [100.98.43.211] (unknown [5.62.51.38])
        by st43p00im-zteg10073401.me.com (Postfix) with ESMTPSA id 5887A5E0355;
        Fri,  6 Dec 2019 01:32:23 +0000 (UTC)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: is this the right place for a question on how to repair a broken
 btrfs file system?
From:   Christian Wimmer <telefonchris@icloud.com>
In-Reply-To: <522495ca-ed55-dd81-a819-dab93e67d0aa@gmx.com>
Date:   Thu, 5 Dec 2019 22:32:22 -0300
Cc:     Hugo Mills <hugo@carfax.org.uk>, linux-btrfs@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9FD0858D-013F-4C02-B312-C983AFF1CCFC@icloud.com>
References: <A01B0EC4-8E96-486B-A182-76B74AD0F97D@icloud.com>
 <20191205202449.GH4760@savella.carfax.org.uk>
 <61D37CED-8564-49BC-9388-4A8511C3AC50@icloud.com>
 <522495ca-ed55-dd81-a819-dab93e67d0aa@gmx.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
X-Mailer: Apple Mail (2.3601.0.10)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-12-05_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1912060011
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Hugo and Qu,

here the output from the commands:

# btrfs ins dump-tree -t root /dev/sde1 2>&1
btrfs-progs v4.19.1=20
checksum verify failed on 5349895454720 found B80B9FA8 wanted C61C3C00
checksum verify failed on 5349895454720 found B80B9FA8 wanted C61C3C00
checksum verify failed on 5349895454720 found B80B9FA8 wanted C61C3C00
checksum verify failed on 5349895454720 found B80B9FA8 wanted C61C3C00
bad tree block 5349895454720, bytenr mismatch, want=3D5349895454720, =
have=3D14275350892879035392
Couldn't setup device tree
ERROR: unable to open /dev/sde1
#=20



# btrfs ins dump-tree -t extent /dev/sde1 2>&1 >/dev/null
checksum verify failed on 5349895454720 found B80B9FA8 wanted C61C3C00
checksum verify failed on 5349895454720 found B80B9FA8 wanted C61C3C00
checksum verify failed on 5349895454720 found B80B9FA8 wanted C61C3C00
checksum verify failed on 5349895454720 found B80B9FA8 wanted C61C3C00
bad tree block 5349895454720, bytenr mismatch, want=3D5349895454720, =
have=3D14275350892879035392
Couldn't setup device tree
ERROR: unable to open /dev/sde1
#=20


# btrfs ins dump-tree -t chunk /dev/sde1
btrfs-progs v4.19.1=20
checksum verify failed on 5349895454720 found B80B9FA8 wanted C61C3C00
checksum verify failed on 5349895454720 found B80B9FA8 wanted C61C3C00
checksum verify failed on 5349895454720 found B80B9FA8 wanted C61C3C00
checksum verify failed on 5349895454720 found B80B9FA8 wanted C61C3C00
bad tree block 5349895454720, bytenr mismatch, want=3D5349895454720, =
have=3D14275350892879035392
Couldn't setup device tree
ERROR: unable to open /dev/sde1
#=20


# btrfs ins dump-tree -t 5 /dev/sde1 2>&1 >/dev/null
checksum verify failed on 5349895454720 found B80B9FA8 wanted C61C3C00
checksum verify failed on 5349895454720 found B80B9FA8 wanted C61C3C00
checksum verify failed on 5349895454720 found B80B9FA8 wanted C61C3C00
checksum verify failed on 5349895454720 found B80B9FA8 wanted C61C3C00
bad tree block 5349895454720, bytenr mismatch, want=3D5349895454720, =
have=3D14275350892879035392
Couldn't setup device tree
ERROR: unable to open /dev/sde1
#=20


I will try to setup a newer kernel. Which Distro you would suggest for =
this purpose?
The idea is to download and install a small linux just for recovery =
purpose for now.

Thanks,

Chris

