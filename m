Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4E481303B7
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Jan 2020 18:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgADRHP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 4 Jan 2020 12:07:15 -0500
Received: from ms11p00im-qufo17282101.me.com ([17.58.38.58]:52455 "EHLO
        ms11p00im-qufo17282101.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726004AbgADRHP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 4 Jan 2020 12:07:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1578157631;
        bh=Ng+/xW9G1nqUkW+f+wTkMtQU0y9/gNZ9lZXpG7KoUl4=;
        h=Content-Type:Subject:From:Date:Message-Id:To;
        b=pkE61EO202IVC0Lpa20oyO8Qcp4DnTd6T7Kg8h73WMHxVoGGWINFXWgV9CLZ53dzQ
         w/QHTtfZtF6N1qZ9+LPgF87x3KCa8fkI8ZcFtDSKf2hcRG+n3njU0rplQ/eAM8Kkdy
         Okl/LJf9AVCJ39MDwZVeyFwsYLld6k5YYxh2fxr8VUiysUnMLSGlR4by3yXoFnDIzq
         7IS0Sq9cSzyLqokzXZ9s4YB4OhKgSMaU659ez0FiNH5TFa2GStBNRbCY+2vWMOYcQx
         96APLVf5dg3fhjqTAv4A/GQ4ezleVHSwV+8J9xjbiEKRbkckKdZNVZmpmW6ik0ua8n
         m6TXAAoDMXoeQ==
Received: from [192.168.15.23] (unknown [177.76.36.47])
        by ms11p00im-qufo17282101.me.com (Postfix) with ESMTPSA id C8A8E780411;
        Sat,  4 Jan 2020 17:07:10 +0000 (UTC)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: 12 TB btrfs file system on virtual machine broke again
From:   Christian Wimmer <telefonchris@icloud.com>
In-Reply-To: <9FB359ED-EAD4-41DD-B846-1422F2DC4242@icloud.com>
Date:   Sat, 4 Jan 2020 14:07:08 -0300
Cc:     Qu WenRuo <wqu@suse.com>, Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <256D0504-6AEE-4A0E-9C62-CDF975FDE32D@icloud.com>
References: <20191206034406.40167-1-wqu@suse.com>
 <2a220d44-fb44-66cf-9414-f1d0792a5d4f@oracle.com>
 <762365A0-8BDF-454B-ABA9-AB2F0C958106@icloud.com>
 <94a6d1b2-ae32-5564-22ee-6982e952b100@suse.com>
 <4C0C9689-3ECF-4DF7-9F7E-734B6484AA63@icloud.com>
 <f7fe057d-adc1-ace5-03b3-0f0e608d68a3@gmx.com>
 <9FB359ED-EAD4-41DD-B846-1422F2DC4242@icloud.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2020-01-04_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-2001040161
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi guys,=20

I run again in a problem with my btrfs files system.
I start wondering if this filesystem type is right for my needs.
Could you please help me in recovering my 12TB partition?

What happened?=20
-> This time I was just rebooting normally my virtual machine. I =
discovered during the past days that the system hangs for some seconds =
so I thought it would be a good idea to reboot my SUSE Linux after 14 =
days of working. The machine powered off normally but when starting it =
run into messages like the pasted ones.

I immediately powered off again and started my Arch Linux where I have =
btrfs-progs version 5.4 installed.
I tried one of the commands that you gave me in the past (restore) and I =
got following messages:


btrfs-progs-5.4]# ./btrfs restore -l /dev/sdb1
checksum verify failed on 3181912915968 found 000000A9 wanted 00000064
checksum verify failed on 3181912915968 found 00000071 wanted 00000066
checksum verify failed on 3181912915968 found 000000A9 wanted 00000064
bad tree block 3181912915968, bytenr mismatch, want=3D3181912915968, =
have=3D4908658797358025935
checksum verify failed on 2688520683520 found 000000D5 wanted FFFFFFA9
checksum verify failed on 2688520683520 found 000000EE wanted FFFFFFEB
checksum verify failed on 2688520683520 found 000000D5 wanted FFFFFFA9
bad tree block 2688520683520, bytenr mismatch, want=3D2688520683520, =
have=3D10123237912294
Could not open root, trying backup super
checksum verify failed on 3181912915968 found 000000A9 wanted 00000064
checksum verify failed on 3181912915968 found 00000071 wanted 00000066
checksum verify failed on 3181912915968 found 000000A9 wanted 00000064
bad tree block 3181912915968, bytenr mismatch, want=3D3181912915968, =
have=3D4908658797358025935
checksum verify failed on 2688520683520 found 000000D5 wanted FFFFFFA9
checksum verify failed on 2688520683520 found 000000EE wanted FFFFFFEB
checksum verify failed on 2688520683520 found 000000D5 wanted FFFFFFA9
bad tree block 2688520683520, bytenr mismatch, want=3D2688520683520, =
have=3D10123237912294
Could not open root, trying backup super
checksum verify failed on 3181912915968 found 000000A9 wanted 00000064
checksum verify failed on 3181912915968 found 00000071 wanted 00000066
checksum verify failed on 3181912915968 found 000000A9 wanted 00000064
bad tree block 3181912915968, bytenr mismatch, want=3D3181912915968, =
have=3D4908658797358025935
checksum verify failed on 2688520683520 found 000000D5 wanted FFFFFFA9
checksum verify failed on 2688520683520 found 000000EE wanted FFFFFFEB
checksum verify failed on 2688520683520 found 000000D5 wanted FFFFFFA9
bad tree block 2688520683520, bytenr mismatch, want=3D2688520683520, =
have=3D10123237912294
Could not open root, trying backup super
btrfs-progs-5.4]#=20



What can I do now to recover files?

Please help me.

Thanks,

Chris


