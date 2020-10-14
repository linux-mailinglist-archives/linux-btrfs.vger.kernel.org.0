Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41ED128DEEB
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Oct 2020 12:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbgJNKaD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Oct 2020 06:30:03 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:46670 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgJNKaD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Oct 2020 06:30:03 -0400
Received: from relay4-d.mail.gandi.net (unknown [217.70.183.196])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id EEB613A0F92
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Oct 2020 10:01:42 +0000 (UTC)
X-Originating-IP: 82.67.131.7
Received: from [192.168.1.168] (unknown [82.67.131.7])
        (Authenticated sender: swami@petaramesh.org)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id DEB8CE0013;
        Wed, 14 Oct 2020 10:01:20 +0000 (UTC)
To:     linux-btrfs@vger.kernel.org
From:   =?UTF-8?Q?Sw=c3=a2mi_Petaramesh?= <swami@petaramesh.org>
Subject: [BUG] in btrfs scrub status
Autocrypt: addr=swami@petaramesh.org; prefer-encrypt=mutual; keydata=
 mQGiBEP8C/QRBADPiYmcQstlx+HdyR2FGH+bDgRZ0ZJBAx6F0OPW+CmIa6tlwdhSFtCTJGcw
 eqCgSKqzLS+WBd6qknpGP3D2GOmASt+Juqnl+qmX8F/XrkxSNOVGGD0vkKGX4H5uDwufWkuV
 7kD/0VFJg2areJXx5tIK4+IR0E0O4Yv6DmBPwPgNUwCg0OdUy9lbCxMmshwJDGUX2Y/hiDsD
 /3YTjHYH2OMTg/5xXlkQgR4aWn8SaVTG1vJPcm2j2BMq1LUNklgsKw7qJToRjFndHCYjSeqF
 /Yk2Cbeez9qIk3lX2M59CTwbHPZAk7fCEVg1Wf7RvR2i4zEDBWKd3nChALaXLE3mTWOE1pf8
 mUNPLALisxKDUkgyrwM4rZ28kKxyA/960xC5VVMkHWYYiisQQy2OQk+ElxSfPz5AWB5ijdJy
 SJXOT/xvgswhurPRcJc+l8Ld1GWKyey0o+EBlbkAcaZJ8RCGX77IJGG3NKDBoBN7fGXv3xQZ
 mFLbDyZWjQHl33wSUcskw2IP0D/vjRk/J7rHajIk+OxgbuTkeXF1qwX2ybQoU3fDom1pIFBl
 dGFyYW1lc2ggPHN3YW1pQHBldGFyYW1lc2gub3JnPoh+BBMRAgA+AhsDAh4BAheABQsJCAcC
 BhUKCQgLAgQWAgMBFiEEzB/joG05+rK5HJguL8JcHZB24y4FAl0Cdr0FCSJsbEkACgkQL8Jc
 HZB24y7PrwCeIj82AsMnwgOebV274cWEyR/yaDsAn25VN/Hw+yzkeXWAn5uIWJ+ZsoZkuQQN
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
 TYaSBqmVw+0A3IKIZgQYEQIAJgIbDBYhBMwf46BtOfqyuRyYLi/CXB2QduMuBQJdAnbyBQki
 bGwWAAoJEC/CXB2QduMur1wAn1X3FcsmMdhMfiYwXw7LVw4FAIeWAJ9kLGer22WFWR2z2iU7
 BtUAN08OPA==
Message-ID: <a17a65d0-68d4-e220-0b2d-5c19cdc7be20@petaramesh.org>
Date:   Wed, 14 Oct 2020 12:01:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

# btrfs version
btrfs-progs v5.7

When the filesystem has grown during scrub and “Total to scrub” becomes
less than actually scrubbed, some counters overflows and the “time left”
and ETA becomes fun.

# btrfs scrub stat /
UUID:             [---edited---]
Scrub started:    Wed Oct 14 07:36:06 2020
Status:           running
Duration:         4:21:02
Time left:        27070599:41:03
ETA:              Sun Dec 27 02:38:14 5108
Total to scrub:   2.69TiB
Bytes scrubbed:   2.70TiB
Rate:             180.52MiB/s
Error summary:    no errors found


ॐ

-- 
Swâmi Petaramesh <swami@petaramesh.org> PGP 9076E32E
