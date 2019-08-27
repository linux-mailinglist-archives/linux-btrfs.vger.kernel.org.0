Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB789E640
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2019 12:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728845AbfH0K7k (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Aug 2019 06:59:40 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:38027 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfH0K7k (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Aug 2019 06:59:40 -0400
X-Originating-IP: 88.191.131.7
Received: from [192.168.1.167] (unknown [88.191.131.7])
        (Authenticated sender: swami@petaramesh.org)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 5AECE20006;
        Tue, 27 Aug 2019 10:59:37 +0000 (UTC)
Subject: Re: Massive filesystem corruption since kernel 5.2 (ARCH)
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Cc:     Christoph Anton Mitterer <calestyo@scientia.net>
References: <11e4e889f903ddad682297c4420faeb0245414cf.camel@scientia.net>
 <18d24f2f-4d33-10aa-5052-c358d4f7c328@petaramesh.org>
 <a8968a812e270a0dd80c4cf431a8437d3a7daba5.camel@scientia.net>
 <5aefca34-224a-0a81-c930-4ccfcd144aef@petaramesh.org>
 <4bd70aa2-7ad0-d5c6-bc1f-22340afaac60@petaramesh.org>
 <370697f1-24c9-c8bd-01a7-c2885a7ece05@gmx.com>
From:   =?UTF-8?Q?Sw=c3=a2mi_Petaramesh?= <swami@petaramesh.org>
Openpgp: preference=signencrypt
Autocrypt: addr=swami@petaramesh.org; prefer-encrypt=mutual; keydata=
 xsDiBEP8C/QRBADPiYmcQstlx+HdyR2FGH+bDgRZ0ZJBAx6F0OPW+CmIa6tlwdhSFtCTJGcw
 eqCgSKqzLS+WBd6qknpGP3D2GOmASt+Juqnl+qmX8F/XrkxSNOVGGD0vkKGX4H5uDwufWkuV
 7kD/0VFJg2areJXx5tIK4+IR0E0O4Yv6DmBPwPgNUwCg0OdUy9lbCxMmshwJDGUX2Y/hiDsD
 /3YTjHYH2OMTg/5xXlkQgR4aWn8SaVTG1vJPcm2j2BMq1LUNklgsKw7qJToRjFndHCYjSeqF
 /Yk2Cbeez9qIk3lX2M59CTwbHPZAk7fCEVg1Wf7RvR2i4zEDBWKd3nChALaXLE3mTWOE1pf8
 mUNPLALisxKDUkgyrwM4rZ28kKxyA/960xC5VVMkHWYYiisQQy2OQk+ElxSfPz5AWB5ijdJy
 SJXOT/xvgswhurPRcJc+l8Ld1GWKyey0o+EBlbkAcaZJ8RCGX77IJGG3NKDBoBN7fGXv3xQZ
 mFLbDyZWjQHl33wSUcskw2IP0D/vjRk/J7rHajIk+OxgbuTkeXF1qwX2yc0oU3fDom1pIFBl
 dGFyYW1lc2ggPHN3YW1pQHBldGFyYW1lc2gub3JnPsJ+BBMRAgA+AhsDAh4BAheABQsJCAcC
 BhUKCQgLAgQWAgMBFiEEzB/joG05+rK5HJguL8JcHZB24y4FAl0Cdr0FCSJsbEkACgkQL8Jc
 HZB24y7PrwCeIj82AsMnwgOebV274cWEyR/yaDsAn25VN/Hw+yzkeXWAn5uIWJ+ZsoZkzsNN
 BEP8DFwQEAC77CwwyVuzngvfFTx2UzFwFOZ25osxSYE1Hpw249kbeK09EYbvMYzcWR34vbS0
 DhxqwJYH9uSuMZf/Jp4Qa/oYN4x4ZMeOGc5+BdigcetQQnZkIpMaCdFm6HK/A4aqCjqbPpvF
 3Mtd4CXcl1v94pIWq/n9JrLNclUA7rWnVKkPDqJ8WaxzDWm2YH9l1H+K+JbU/ow+Rk+y5xqp
 jL3XpOsVqf34RQhFUyCoysvvxH8RdHAeKfWTf5x6P8jOvxB6XwOnKkX91kC2N7PzoDxY7llY
 Uvy+ehrVVpaKLJ1a1R2eaVIHTFGO//2ARn6g4vVPMB93FLNR0BOGzEXCnnJKO5suw9Njv/aL
 bdnVdDPt9nc1yn3o8Bx/nZq1asX3zo/PnMz4Up24l6GrakJFMBZybX/KxA0CXDK6Rq4HSphI
 y/+v0I27FiQm7oT4ykiKnfFuh16NWM8rPV0UQgBLxSBoz327bUpsRuSrYh/oYBbE6p5KYHlB
 Acpix7wQ61OdUihBX73/AAx0Gd53fc0d4AYeKy4JXMl2uP2aiIvBeBaOKY5tzIq9gnL5K6rr
 xt4PSeONoLdVo8m8OyYeao1zvpgeNZ6FJ+VCYGBtsZEYIi80Ez5V0PpgAh7kSY1xbimDqKQx
 A/Jq2Q7sXBCdUeHN5cDgOZLKoJRvat/rhNaCSgUNfhUc2wADBRAAskb9Eolxs20NCfs424b3
 /NRI7SVn9W2hXvI61UYfs19lfScnn9YfmiN7IdB2cLCE6OiAbSsK3Aw8HDnEc0AdylVNOiIK
 su7C4+CW6HKMyIUm1q2qv8RwW3K8eE8+S4+4/5k+38T39BlC3HcLSxS9vfgqmF6mF6VeD5Mn
 DDbrm7G06UFm1Eh5PKFSzYKZ4i9rD9R4ivDCxRBT9Cibw36iigdp14z87/Qq/NoFe8j9zrbs
 3/3XZ22NxS0G8aNi0ejgDeYVRUUudBXK7zjV/pJDS4luB9iOiblysJmdKI3EegHlAcapTASn
 qsJ42O/Uv9jdSPPruZrMbeRKILqOl/YtI0orHGW/UzMYf/vbYWZ82azkPQqKDZF3Tb3h6ZHt
 csifD/J9IN7xh71aPf8ayIAus1AtPFtPUTjIJXqXIvAlNcDpaEpxn8xxcbVdcRBU/odASwsX
 IPdz8/HV5esod/QhR6/16kkKyOJNF5M/qC3PLur8Zu4iRu8EPiPr6vTAjhLrfXbQycuVc4CV
 c+hGlyYSW0xFaT+XF/4d+KZirsu07P5w/OCu+oRhH4StCOz58KrtuaX1dK5nLk6XkM4nKZhC
 7kmpnPqS6BkdJngkozuKQZMJahIvFglag90xgLrOl5MtO55yr/0j4S4a8GxTkVs70GttcMKN
 TYaSBqmVw+0A3ILCZgQYEQIAJgIbDBYhBMwf46BtOfqyuRyYLi/CXB2QduMuBQJdAnbyBQki
 bGwWAAoJEC/CXB2QduMur1wAn1X3FcsmMdhMfiYwXw7LVw4FAIeWAJ9kLGer22WFWR2z2iU7
 BtUAN08OPA==
Message-ID: <fcd2e070-67e9-4889-f778-748070cc9856@petaramesh.org>
Date:   Tue, 27 Aug 2019 12:59:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <370697f1-24c9-c8bd-01a7-c2885a7ece05@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi again,

Le 27/08/2019 à 08:21, Qu Wenruo a écrit :
> I'd prefer to do a "btrfs check --readonly" anyway (which also checks
> free space cache), then go nospace_cache if you're concerned.

Here's what I dit, here's what I got...:

root@PartedMagic:~# uname -r
5.1.5-pmagic64

root@PartedMagic:~# btrfs --version
btrfs-progs v5.1

root@PartedMagic:~# btrfs check --readonly /dev/PPL_VG1/LINUX
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
block group 52677312512 has wrong amount of free space, free space cache
has 266551296 block group has 266584064
failed to load free space cache for block group 52677312512
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
Opening filesystem to check...
Checking filesystem on /dev/PPL_VG1/LINUX
UUID: 25fede5a-d8c2-4c7e-9e7e-b19aad319044
found 87804731392 bytes used, no error found
total csum bytes: 79811080
total tree bytes: 2195832832
total fs tree bytes: 1992900608
total extent tree bytes: 101548032
btree space waste bytes: 380803707
file data blocks allocated: 626135830528
 referenced 124465221632

root@PartedMagic:~# mkdir /hd
root@PartedMagic:~# mount -t btrfs -o noatime,clear_cache
/dev/PPL_VG1/LINUX /hd

(Waited for no disk activity and top showing no btrfs processes)

root@PartedMagic:~# umount /hd

root@PartedMagic:~# mount -t btrfs -o noatime /dev/PPL_VG1/LINUX /hd

root@PartedMagic:~# grep btrfs /proc/self/mountinfo
40 31 0:43 / /hd rw,noatime - btrfs /dev/mapper/PPL_VG1-LINUX
rw,ssd,space_cache,subvolid=5,subvol=/

root@PartedMagic:~# umount /hd

root@PartedMagic:~# btrfs check --readonly /dev/PPL_VG1/LINUX
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
block group 52677312512 has wrong amount of free space, free space cache
has 266551296 block group has 266584064
failed to load free space cache for block group 52677312512
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
Opening filesystem to check...
Checking filesystem on /dev/PPL_VG1/LINUX
UUID: 25fede5a-d8c2-4c7e-9e7e-b19aad319044
found 87804207104 bytes used, no error found
total csum bytes: 79811080
total tree bytes: 2195832832
total fs tree bytes: 1992900608
total extent tree bytes: 101548032
btree space waste bytes: 380804019
file data blocks allocated: 626135306240
 referenced 124464697344
root@PartedMagic:~#


So it seems that mounting with “clear_cache” did not actually clear the
cache and fix the issue ?

ॐ

-- 
Swâmi Petaramesh <swami@petaramesh.org> PGP 9076E32E
