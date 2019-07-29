Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A929378D55
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2019 16:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfG2OBI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Jul 2019 10:01:08 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:46613 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbfG2OBI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Jul 2019 10:01:08 -0400
X-Originating-IP: 88.191.131.7
Received: from [192.168.1.167] (unknown [88.191.131.7])
        (Authenticated sender: swami@petaramesh.org)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id CD925E000C;
        Mon, 29 Jul 2019 14:01:01 +0000 (UTC)
Subject: Re: Massive filesystem corruption since kernel 5.2 (ARCH)
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <bcb1a04b-f0b0-7699-92af-501e774de41a@petaramesh.org>
 <c336ccf4-34f5-a844-888c-cd63d8dc5c4e@petaramesh.org>
 <0ce15d14-9f30-ac83-0964-8e695eca8cbd@gmx.com>
 <325a96b2-e6a4-91e3-3b07-1d20a5a031af@petaramesh.org>
 <49785aa8-fb71-8e0e-bd1d-1e3cda4c7036@gmx.com>
 <39d43f92-413c-2184-b8da-2c6073b5223f@petaramesh.org>
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
Message-ID: <b7037726-14dd-a1a2-238f-b5d0d43e3c80@petaramesh.org>
Date:   Mon, 29 Jul 2019 16:01:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <39d43f92-413c-2184-b8da-2c6073b5223f@petaramesh.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Le 29/07/2019 à 15:52, Swâmi Petaramesh a écrit :
> 
> Please tell me how I could help.

Here is the complete output of BTRFS check, ressembling exactly to what
I saw on the 1st disk that broke.

QUESTION : If I run « btrfs check » in repair mode, is there any hope it
will repair the FS properly - I can afford to lose the damaged files,
that's not a problem for me.


# btrfs check /dev/mapper/luks-UUID
Opening filesystem to check...
Checking filesystem on /dev/mapper/luks-UUID
UUID: ==UUID==
[1/7] checking root items
[2/7] checking extents
parent transid verify failed on 2137144377344 wanted 7684 found 7499
parent transid verify failed on 2137144377344 wanted 7684 found 7499
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
leaf parent key incorrect 2137144377344
bad block 2137144377344
ERROR: errors found in extent allocation tree or chunk allocation
[3/7] checking free space cache
[4/7] checking fs roots
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
Wrong key of child node/leaf, wanted: (1797454, 96, 23), have:
(18446744073709551606, 128, 2538887163904)
Wrong generation of child node/leaf, wanted: 7499, have: 7684
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
parent transid verify failed on 2137144377344 wanted 7684 found 7499
Ignoring transid failure
root 2815 inode 1797454 errors 200, dir isize wrong
root 2815 inode 1797455 errors 2001, no inode item, link count wrong
	unresolved ref dir 1767611 index 5 namelen 2 name fs filetype 2 errors
4, no inode ref
root 2815 inode 1797456 errors 2001, no inode item, link count wrong
	unresolved ref dir 1767611 index 6 namelen 3 name lib filetype 2 errors
4, no inode ref
root 2815 inode 1797457 errors 2001, no inode item, link count wrong
	unresolved ref dir 1767611 index 7 namelen 4 name misc filetype 2
errors 4, no inode ref
root 2815 inode 1797458 errors 2001, no inode item, link count wrong
	unresolved ref dir 1767611 index 8 namelen 2 name mm filetype 2 errors
4, no inode ref
root 2815 inode 1797459 errors 2001, no inode item, link count wrong
	unresolved ref dir 1767611 index 9 namelen 3 name net filetype 2 errors
4, no inode ref
	unresolved ref dir 1797454 index 23 namelen 8 name firmware filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 24 namelen 3 name fmc filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 25 namelen 4 name fpga filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 26 namelen 3 name fsi filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 27 namelen 4 name gnss filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 28 namelen 4 name gpio filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 29 namelen 3 name gpu filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 30 namelen 3 name hid filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 31 namelen 3 name hsi filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 32 namelen 2 name hv filetype 2 errors
2, no dir index
	unresolved ref dir 1797454 index 33 namelen 5 name hwmon filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 34 namelen 9 name hwtracing filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 35 namelen 3 name i2c filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 36 namelen 3 name i3c filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 37 namelen 3 name iio filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 38 namelen 10 name infiniband filetype
2 errors 2, no dir index
	unresolved ref dir 1797454 index 39 namelen 5 name input filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 40 namelen 12 name interconnect
filetype 2 errors 2, no dir index
	unresolved ref dir 1797454 index 41 namelen 5 name iommu filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 42 namelen 5 name ipack filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 43 namelen 7 name irqchip filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 44 namelen 4 name isdn filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 45 namelen 4 name leds filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 46 namelen 8 name lightnvm filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 47 namelen 9 name macintosh filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 48 namelen 7 name mailbox filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 49 namelen 3 name mcb filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 50 namelen 2 name md filetype 2 errors
2, no dir index
	unresolved ref dir 1797454 index 51 namelen 5 name media filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 52 namelen 8 name memstick filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 53 namelen 7 name message filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 54 namelen 3 name mfd filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 55 namelen 4 name misc filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 56 namelen 3 name mmc filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 57 namelen 3 name mtd filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 58 namelen 3 name mux filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 59 namelen 3 name net filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 60 namelen 3 name nfc filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 61 namelen 3 name ntb filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 62 namelen 6 name nvdimm filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 63 namelen 4 name nvme filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 64 namelen 5 name nvmem filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 65 namelen 2 name of filetype 2 errors
2, no dir index
	unresolved ref dir 1797454 index 66 namelen 7 name parport filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 67 namelen 3 name pci filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 68 namelen 6 name pcmcia filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 69 namelen 3 name phy filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 70 namelen 7 name pinctrl filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 71 namelen 8 name platform filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 72 namelen 5 name power filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 73 namelen 8 name powercap filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 74 namelen 3 name pps filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 75 namelen 3 name ptp filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 76 namelen 3 name pwm filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 77 namelen 7 name rapidio filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 78 namelen 9 name regulator filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 79 namelen 10 name remoteproc filetype
2 errors 2, no dir index
	unresolved ref dir 1797454 index 80 namelen 5 name reset filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 81 namelen 5 name rpmsg filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 82 namelen 3 name rtc filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 83 namelen 4 name scsi filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 84 namelen 4 name siox filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 85 namelen 7 name slimbus filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 86 namelen 3 name soc filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 87 namelen 9 name soundwire filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 88 namelen 3 name spi filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 89 namelen 4 name spmi filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 90 namelen 3 name ssb filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 91 namelen 7 name staging filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 92 namelen 6 name target filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 93 namelen 7 name thermal filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 94 namelen 11 name thunderbolt
filetype 2 errors 2, no dir index
	unresolved ref dir 1797454 index 95 namelen 3 name tty filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 96 namelen 3 name uio filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 97 namelen 3 name usb filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 98 namelen 3 name uwb filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 99 namelen 4 name vfio filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 100 namelen 5 name vhost filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 101 namelen 5 name video filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 102 namelen 4 name virt filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 103 namelen 6 name virtio filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 104 namelen 8 name visorbus filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 105 namelen 3 name vme filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 106 namelen 2 name w1 filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 107 namelen 8 name watchdog filetype 2
errors 2, no dir index
	unresolved ref dir 1797454 index 108 namelen 3 name xen filetype 2
errors 2, no dir index
root 2815 inode 1802706 errors 2000, link count wrong
	unresolved ref dir 1797455 index 2 namelen 2 name 9p filetype 0 errors
3, no dir item, no dir index
root 2815 inode 1802707 errors 2000, link count wrong
	unresolved ref dir 1797455 index 3 namelen 4 name affs filetype 0
errors 3, no dir item, no dir index
root 2815 inode 1802708 errors 2000, link count wrong
	unresolved ref dir 1797455 index 4 namelen 3 name afs filetype 0 errors
3, no dir item, no dir index
root 2815 inode 1802709 errors 2000, link count wrong
	unresolved ref dir 1797455 index 5 namelen 4 name befs filetype 0
errors 3, no dir item, no dir index
root 2815 inode 1802710 errors 2000, link count wrong
	unresolved ref dir 1797455 index 6 namelen 5 name btrfs filetype 0
errors 3, no dir item, no dir index
root 2815 inode 1802711 errors 2000, link count wrong
	unresolved ref dir 1797455 index 7 namelen 10 name cachefiles filetype
0 errors 3, no dir item, no dir index
root 2815 inode 1802712 errors 2000, link count wrong
	unresolved ref dir 1797455 index 8 namelen 4 name ceph filetype 0
errors 3, no dir item, no dir index
root 2815 inode 1802713 errors 2000, link count wrong
	unresolved ref dir 1797455 index 9 namelen 4 name cifs filetype 0
errors 3, no dir item, no dir index
root 2815 inode 1802714 errors 2000, link count wrong
	unresolved ref dir 1797455 index 10 namelen 4 name coda filetype 0
errors 3, no dir item, no dir index
root 2815 inode 1802715 errors 2000, link count wrong
	unresolved ref dir 1797455 index 11 namelen 6 name cramfs filetype 0
errors 3, no dir item, no dir index
root 2815 inode 1802716 errors 2000, link count wrong
	unresolved ref dir 1797455 index 12 namelen 3 name dlm filetype 0
errors 3, no dir item, no dir index
root 2815 inode 1802717 errors 2000, link count wrong
	unresolved ref dir 1797455 index 13 namelen 8 name ecryptfs filetype 0
errors 3, no dir item, no dir index
root 2815 inode 1802718 errors 2000, link count wrong
	unresolved ref dir 1797455 index 14 namelen 4 name ext4 filetype 0
errors 3, no dir item, no dir index
root 2815 inode 1802719 errors 2000, link count wrong
	unresolved ref dir 1797455 index 15 namelen 4 name f2fs filetype 0
errors 3, no dir item, no dir index
root 2815 inode 1802720 errors 2000, link count wrong
	unresolved ref dir 1797455 index 16 namelen 3 name fat filetype 0
errors 3, no dir item, no dir index
root 2815 inode 1802721 errors 2000, link count wrong
	unresolved ref dir 1797455 index 17 namelen 7 name fscache filetype 0
errors 3, no dir item, no dir index
root 2815 inode 1802722 errors 2000, link count wrong
	unresolved ref dir 1797455 index 18 namelen 4 name fuse filetype 0
errors 3, no dir item, no dir index
root 2815 inode 1802723 errors 2000, link count wrong
	unresolved ref dir 1797455 index 19 namelen 4 name gfs2 filetype 0
errors 3, no dir item, no dir index
root 2815 inode 1802724 errors 2000, link count wrong
	unresolved ref dir 1797455 index 20 namelen 3 name hfs filetype 0
errors 3, no dir item, no dir index
root 2815 inode 1802725 errors 2000, link count wrong
	unresolved ref dir 1797455 index 21 namelen 7 name hfsplus filetype 0
errors 3, no dir item, no dir index
root 2815 inode 1802726 errors 2000, link count wrong
	unresolved ref dir 1797455 index 22 namelen 5 name isofs filetype 0
errors 3, no dir item, no dir index
root 2815 inode 1802727 errors 2000, link count wrong
	unresolved ref dir 1797455 index 23 namelen 4 name jbd2 filetype 0
errors 3, no dir item, no dir index
root 2815 inode 1802728 errors 2000, link count wrong
	unresolved ref dir 1797455 index 24 namelen 5 name jffs2 filetype 0
errors 3, no dir item, no dir index
root 2815 inode 1802729 errors 2000, link count wrong
	unresolved ref dir 1797455 index 25 namelen 3 name jfs filetype 0
errors 3, no dir item, no dir index
root 2815 inode 1802730 errors 2000, link count wrong
	unresolved ref dir 1797455 index 26 namelen 5 name lockd filetype 0
errors 3, no dir item, no dir index
root 2815 inode 1802731 errors 2000, link count wrong
	unresolved ref dir 1797455 index 27 namelen 5 name minix filetype 0
errors 3, no dir item, no dir index
root 2815 inode 1802732 errors 2000, link count wrong
	unresolved ref dir 1797455 index 28 namelen 3 name nfs filetype 0
errors 3, no dir item, no dir index
root 2815 inode 1802733 errors 2000, link count wrong
	unresolved ref dir 1797455 index 29 namelen 10 name nfs_common filetype
0 errors 3, no dir item, no dir index
root 2815 inode 1802734 errors 2000, link count wrong
	unresolved ref dir 1797455 index 30 namelen 4 name nfsd filetype 0
errors 3, no dir item, no dir index
root 2815 inode 1802735 errors 2000, link count wrong
	unresolved ref dir 1797455 index 31 namelen 6 name nilfs2 filetype 0
errors 3, no dir item, no dir index
root 2815 inode 1802736 errors 2000, link count wrong
	unresolved ref dir 1797455 index 32 namelen 3 name nls filetype 0
errors 3, no dir item, no dir index
root 2815 inode 1802737 errors 2000, link count wrong
	unresolved ref dir 1797455 index 33 namelen 4 name ntfs filetype 0
errors 3, no dir item, no dir index
root 2815 inode 1802738 errors 2000, link count wrong
	unresolved ref dir 1797455 index 34 namelen 5 name ocfs2 filetype 0
errors 3, no dir item, no dir index
root 2815 inode 1802739 errors 2000, link count wrong
	unresolved ref dir 1797455 index 35 namelen 4 name omfs filetype 0
errors 3, no dir item, no dir index
root 2815 inode 1802740 errors 2000, link count wrong
	unresolved ref dir 1797455 index 36 namelen 8 name orangefs filetype 0
errors 3, no dir item, no dir index
root 2815 inode 1802741 errors 2000, link count wrong
	unresolved ref dir 1797455 index 37 namelen 9 name overlayfs filetype 0
errors 3, no dir item, no dir index
root 2815 inode 1802742 errors 2000, link count wrong
	unresolved ref dir 1797455 index 38 namelen 5 name quota filetype 0
errors 3, no dir item, no dir index
root 2815 inode 1802743 errors 2000, link count wrong
	unresolved ref dir 1797455 index 39 namelen 8 name reiserfs filetype 0
errors 3, no dir item, no dir index
root 2815 inode 1802744 errors 2000, link count wrong
	unresolved ref dir 1797455 index 40 namelen 5 name romfs filetype 0
errors 3, no dir item, no dir index
root 2815 inode 1802745 errors 2000, link count wrong
	unresolved ref dir 1797455 index 41 namelen 8 name squashfs filetype 0
errors 3, no dir item, no dir index
root 2815 inode 1802746 errors 2000, link count wrong
	unresolved ref dir 1797455 index 42 namelen 5 name ubifs filetype 0
errors 3, no dir item, no dir index
root 2815 inode 1802748 errors 2000, link count wrong
	unresolved ref dir 1797455 index 43 namelen 3 name udf filetype 0
errors 3, no dir item, no dir index
root 2815 inode 1802749 errors 2000, link count wrong
	unresolved ref dir 1797455 index 44 namelen 3 name ufs filetype 0
errors 3, no dir item, no dir index
root 2815 inode 1802750 errors 2000, link count wrong
	unresolved ref dir 1797455 index 45 namelen 3 name xfs filetype 0
errors 3, no dir item, no dir index
root 2815 inode 1802915 errors 2000, link count wrong
	unresolved ref dir 1797456 index 2 namelen 3 name 842 filetype 0 errors
3, no dir item, no dir index
root 2815 inode 1802916 errors 2000, link count wrong
	unresolved ref dir 1797456 index 3 namelen 3 name lz4 filetype 0 errors
3, no dir item, no dir index
root 2815 inode 1802917 errors 2000, link count wrong
	unresolved ref dir 1797456 index 4 namelen 4 name math filetype 0
errors 3, no dir item, no dir index
root 2815 inode 1802918 errors 2000, link count wrong
	unresolved ref dir 1797456 index 5 namelen 5 name raid6 filetype 0
errors 3, no dir item, no dir index
root 2815 inode 1802945 errors 2000, link count wrong
	unresolved ref dir 1797459 index 2 namelen 7 name 6lowpan filetype 2
errors 1, no dir item
root 2815 inode 1802946 errors 2000, link count wrong
	unresolved ref dir 1797459 index 3 namelen 3 name 802 filetype 2 errors
1, no dir item
root 2815 inode 1802951 errors 2000, link count wrong
	unresolved ref dir 1797459 index 8 namelen 10 name batman-adv filetype
2 errors 1, no dir item
root 2815 inode 1802952 errors 2000, link count wrong
	unresolved ref dir 1797459 index 9 namelen 9 name bluetooth filetype 2
errors 1, no dir item
root 2815 inode 1802953 errors 2000, link count wrong
	unresolved ref dir 1797459 index 10 namelen 6 name bridge filetype 2
errors 1, no dir item
root 2815 inode 1802956 errors 2000, link count wrong
	unresolved ref dir 1797459 index 13 namelen 4 name ceph filetype 2
errors 1, no dir item
root 2815 inode 1802958 errors 2000, link count wrong
	unresolved ref dir 1797459 index 15 namelen 4 name dccp filetype 2
errors 1, no dir item
root 2815 inode 1802961 errors 2000, link count wrong
	unresolved ref dir 1797459 index 18 namelen 3 name hsr filetype 2
errors 1, no dir item
root 2815 inode 1802962 errors 2000, link count wrong
	unresolved ref dir 1797459 index 19 namelen 10 name ieee802154 filetype
2 errors 1, no dir item
root 2815 inode 1802963 errors 2000, link count wrong
	unresolved ref dir 1797459 index 20 namelen 3 name ife filetype 2
errors 1, no dir item
root 2815 inode 1802964 errors 2000, link count wrong
	unresolved ref dir 1797459 index 21 namelen 4 name ipv4 filetype 2
errors 1, no dir item
root 2815 inode 1802967 errors 2000, link count wrong
	unresolved ref dir 1797459 index 24 namelen 3 name key filetype 2
errors 1, no dir item
root 2815 inode 1802971 errors 2000, link count wrong
	unresolved ref dir 1797459 index 28 namelen 9 name mac802154 filetype 2
errors 1, no dir item
root 2815 inode 1802972 errors 2000, link count wrong
	unresolved ref dir 1797459 index 29 namelen 4 name mpls filetype 2
errors 1, no dir item
root 2815 inode 1802973 errors 2000, link count wrong
	unresolved ref dir 1797459 index 30 namelen 9 name netfilter filetype 2
errors 1, no dir item
root 2815 inode 1802974 errors 2000, link count wrong
	unresolved ref dir 1797459 index 31 namelen 7 name netlink filetype 2
errors 1, no dir item
root 2815 inode 1802975 errors 2000, link count wrong
	unresolved ref dir 1797459 index 32 namelen 6 name netrom filetype 2
errors 1, no dir item
root 2815 inode 1802976 errors 2000, link count wrong
	unresolved ref dir 1797459 index 33 namelen 3 name nfc filetype 2
errors 1, no dir item
root 2815 inode 1802977 errors 2000, link count wrong
	unresolved ref dir 1797459 index 34 namelen 3 name nsh filetype 2
errors 1, no dir item
root 2815 inode 1802978 errors 2000, link count wrong
	unresolved ref dir 1797459 index 35 namelen 11 name openvswitch
filetype 2 errors 1, no dir item
root 2815 inode 1802981 errors 2000, link count wrong
	unresolved ref dir 1797459 index 38 namelen 3 name rds filetype 2
errors 1, no dir item
root 2815 inode 1802982 errors 2000, link count wrong
	unresolved ref dir 1797459 index 39 namelen 6 name rfkill filetype 2
errors 1, no dir item
root 2815 inode 1802985 errors 2000, link count wrong
	unresolved ref dir 1797459 index 42 namelen 5 name sched filetype 2
errors 1, no dir item
root 2815 inode 1802992 errors 2000, link count wrong
	unresolved ref dir 1797459 index 49 namelen 5 name wimax filetype 2
errors 1, no dir item
root 2815 inode 1802993 errors 2000, link count wrong
	unresolved ref dir 1797459 index 50 namelen 8 name wireless filetype 2
errors 1, no dir item
root 2815 inode 1803776 errors 2000, link count wrong
	unresolved ref dir 1797455 index 47 namelen 13 name mbcache.ko.xz
filetype 0 errors 3, no dir item, no dir index
root 2815 inode 1803889 errors 2000, link count wrong
	unresolved ref dir 1797456 index 7 namelen 9 name bch.ko.xz filetype 0
errors 3, no dir item, no dir index
root 2815 inode 1803890 errors 2000, link count wrong
	unresolved ref dir 1797456 index 9 namelen 15 name crc-itu-t.ko.xz
filetype 0 errors 3, no dir item, no dir index
root 2815 inode 1803891 errors 2000, link count wrong
	unresolved ref dir 1797456 index 11 namelen 11 name crc16.ko.xz
filetype 0 errors 3, no dir item, no dir index
root 2815 inode 1803892 errors 2000, link count wrong
	unresolved ref dir 1797456 index 13 namelen 10 name crc4.ko.xz filetype
0 errors 3, no dir item, no dir index
root 2815 inode 1803893 errors 2000, link count wrong
	unresolved ref dir 1797456 index 15 namelen 11 name crc64.ko.xz
filetype 0 errors 3, no dir item, no dir index
root 2815 inode 1803894 errors 2000, link count wrong
	unresolved ref dir 1797456 index 17 namelen 10 name crc7.ko.xz filetype
0 errors 3, no dir item, no dir index
root 2815 inode 1803901 errors 2000, link count wrong
	unresolved ref dir 1797456 index 19 namelen 10 name crc8.ko.xz filetype
0 errors 3, no dir item, no dir index
root 2815 inode 1803902 errors 2000, link count wrong
	unresolved ref dir 1797456 index 21 namelen 15 name libcrc32c.ko.xz
filetype 0 errors 3, no dir item, no dir index
root 2815 inode 1803903 errors 2000, link count wrong
	unresolved ref dir 1797456 index 23 namelen 15 name lru_cache.ko.xz
filetype 0 errors 3, no dir item, no dir index
root 2815 inode 1803904 errors 2000, link count wrong
	unresolved ref dir 1797456 index 25 namelen 12 name objagg.ko.xz
filetype 0 errors 3, no dir item, no dir index
root 2815 inode 1803905 errors 2000, link count wrong
	unresolved ref dir 1797456 index 27 namelen 12 name parman.ko.xz
filetype 0 errors 3, no dir item, no dir index
root 2815 inode 1803906 errors 2000, link count wrong
	unresolved ref dir 1797456 index 29 namelen 11 name ts_bm.ko.xz
filetype 0 errors 3, no dir item, no dir index
root 2815 inode 1803907 errors 2000, link count wrong
	unresolved ref dir 1797456 index 31 namelen 12 name ts_fsm.ko.xz
filetype 0 errors 3, no dir item, no dir index
root 2815 inode 1803908 errors 2000, link count wrong
	unresolved ref dir 1797456 index 33 namelen 12 name ts_kmp.ko.xz
filetype 0 errors 3, no dir item, no dir index
root 2815 inode 1803915 errors 2000, link count wrong
	unresolved ref dir 1797457 index 3 namelen 13 name vboxdrv.ko.xz
filetype 0 errors 3, no dir item, no dir index
root 2815 inode 1803916 errors 2000, link count wrong
	unresolved ref dir 1797457 index 5 namelen 16 name vboxnetadp.ko.xz
filetype 0 errors 3, no dir item, no dir index
root 2815 inode 1803917 errors 2000, link count wrong
	unresolved ref dir 1797457 index 7 namelen 16 name vboxnetflt.ko.xz
filetype 0 errors 3, no dir item, no dir index
root 2815 inode 1803918 errors 2000, link count wrong
	unresolved ref dir 1797457 index 9 namelen 13 name vboxpci.ko.xz
filetype 0 errors 3, no dir item, no dir index
root 2815 inode 1803919 errors 2000, link count wrong
	unresolved ref dir 1797458 index 3 namelen 21 name
hwpoison-inject.ko.xz filetype 0 errors 3, no dir item, no dir index
ERROR: errors found in fs roots
found 1681780068352 bytes used, error(s) found
total csum bytes: 1634102612
total tree bytes: 7675002880
total fs tree bytes: 5528207360
total extent tree bytes: 374669312
btree space waste bytes: 1041372744
file data blocks allocated: 2247597993984
 referenced 1803060187136
root:~#

ॐ

-- 
Swâmi Petaramesh <swami@petaramesh.org> PGP 9076E32E
