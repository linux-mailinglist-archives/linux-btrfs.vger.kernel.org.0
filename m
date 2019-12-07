Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77EDB115AE5
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Dec 2019 04:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfLGD4Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 22:56:24 -0500
Received: from ms11p00im-qufo17282101.me.com ([17.58.38.58]:44728 "EHLO
        ms11p00im-qufo17282101.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726371AbfLGD4X (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 6 Dec 2019 22:56:23 -0500
X-Greylist: delayed 548 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Dec 2019 22:56:23 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1575690432;
        bh=6KvQQDGPXK6+Z0d3hV17XHgJHWhYnkeA5cHj2DxW0Ao=;
        h=Content-Type:Subject:From:Date:Message-Id:To;
        b=Qi0SYHg3vtu8dGlGzaSeSziawVNgU38Nts981qru6mOvPjDZCYl1e3qa2NjtmCfqk
         sdy/QTcceW9OQZw5dU9WXuKCHSB61Q4aa72r0bbq1c7UzArQruPjWKUMAa4L0/n25d
         u4z8MojM9rExpqR+Ya6jgWJ+kpt088Y4MEOLc546LgNEXUYrvrlJfRMd2Pab5dDznJ
         D+muVBXNqO1AegbX94Fh3BjixX7dDwbxg5gC8EftUYimKET4LVAcObQb2/Spl1y55F
         MRDvxbABN7CPwiahFigDSs1+EyWA7iCDt4vUCsw4Qs3ywRy60jRYY4lR5HP4+AWT0C
         5kM0kzbWzsOhw==
Received: from [192.168.15.24] (unknown [177.27.216.49])
        by ms11p00im-qufo17282101.me.com (Postfix) with ESMTPSA id 1AD34780D14;
        Sat,  7 Dec 2019 03:47:11 +0000 (UTC)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [PATCH] btrfs-progs: Skip device tree when we failed to read it
From:   Christian Wimmer <telefonchris@icloud.com>
In-Reply-To: <94a6d1b2-ae32-5564-22ee-6982e952b100@suse.com>
Date:   Sat, 7 Dec 2019 00:47:08 -0300
Cc:     Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4C0C9689-3ECF-4DF7-9F7E-734B6484AA63@icloud.com>
References: <20191206034406.40167-1-wqu@suse.com>
 <2a220d44-fb44-66cf-9414-f1d0792a5d4f@oracle.com>
 <762365A0-8BDF-454B-ABA9-AB2F0C958106@icloud.com>
 <94a6d1b2-ae32-5564-22ee-6982e952b100@suse.com>
To:     Qu WenRuo <wqu@suse.com>
X-Mailer: Apple Mail (2.3601.0.10)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-12-06_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=881 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1912070026
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu,


> Chunk tree is good, so is root tree and extent tree.
>=20
> You can go btrfs restore without problem. (Of course, need to use
> patched version)
>=20
> Thanks,
> Qu


Unfortunately I can not restore the contents:

# ./btrfs restore /dev/sdb1 test/
checksum verify failed on 5349895454720 found 000000A8 wanted 00000000
checksum verify failed on 5349895454720 found 000000A8 wanted 00000000
checksum verify failed on 5349895454720 found 000000A8 wanted 00000000
bad tree block 5349895454720, bytenr mismatch, want=3D5349895454720, =
have=3D14275350892879035392
WARNING: could not setup device tree, skipping it
checksum verify failed on 3541835317248 found 00000044 wanted 00000000
checksum verify failed on 3541835317248 found 00000061 wanted 0000001C
checksum verify failed on 3541835317248 found 00000061 wanted 0000001C
bad tree block 3541835317248, bytenr mismatch, want=3D3541835317248, =
have=3D18445340955138505899
Error searching -5
#=20

What else can I try?

Thanks,

Chris


