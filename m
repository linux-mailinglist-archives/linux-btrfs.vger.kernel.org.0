Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 710067A16C
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2019 08:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729111AbfG3Grn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Jul 2019 02:47:43 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:52457 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728477AbfG3Grn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Jul 2019 02:47:43 -0400
Received: from [192.168.1.167] (unknown [88.191.131.7])
        (Authenticated sender: swami@petaramesh.org)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 2753A100005;
        Tue, 30 Jul 2019 06:47:40 +0000 (UTC)
Subject: Re: Massive filesystem corruption since kernel 5.2 (ARCH)
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <bcb1a04b-f0b0-7699-92af-501e774de41a@petaramesh.org>
 <c336ccf4-34f5-a844-888c-cd63d8dc5c4e@petaramesh.org>
 <0ce15d14-9f30-ac83-0964-8e695eca8cbd@gmx.com>
 <325a96b2-e6a4-91e3-3b07-1d20a5a031af@petaramesh.org>
 <49785aa8-fb71-8e0e-bd1d-1e3cda4c7036@gmx.com>
 <39d43f92-413c-2184-b8da-2c6073b5223f@petaramesh.org>
 <b7037726-14dd-a1a2-238f-b5d0d43e3c80@petaramesh.org>
 <71bc824e-1462-50ef-19b1-848c5eb0439d@gmx.com>
 <a08455f0-0ee0-7349-69b3-9cdd00bfe2aa@petaramesh.org>
 <fc26d1e5-ea31-b0c9-0647-63db89a37f53@gmx.com>
 <4aa57293-3f60-8ced-db14-ed38dff7644b@petaramesh.org>
 <43dc92e7-cd13-81db-bbe5-68affcdd317b@gmx.com>
 <a74e3ba6-7106-f2c5-383e-1f75621605a5@petaramesh.org>
 <c5fb61ef-05dc-2bd4-a0aa-d86358d7b82a@gmx.com>
 <5fd82812-22cf-253e-312a-1cfc33f4dfff@petaramesh.org>
 <e8a4ca58-0b5e-96ee-1fa5-552ad7e55785@petaramesh.org>
 <CAJCQCtRgZht7Eh3L_kXfnvLH4WDNMvXXr=EK-9Bn-1tsRKRERg@mail.gmail.com>
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
Message-ID: <1400f092-ab97-1ca6-c411-2728651b118f@petaramesh.org>
Date:   Tue, 30 Jul 2019 08:47:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtRgZht7Eh3L_kXfnvLH4WDNMvXXr=EK-9Bn-1tsRKRERg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Le 29/07/2019 à 21:20, Chris Murphy a écrit :
> I think it's totally reasonable to go back to 5.1 for a while and make
> certain the problems aren't happening there.

That's exactly what I did.

> If they are, then I start
> to wonder about noisy power since you have so many different drives
> and setups affected. Some of the strangest problems I have ever seen
> in computing were directly attributed to noise on the power line.

Yeah, but in this case, being a laptop with the main power being
filtered by the battery, I wouldn't expect a power issue...

Best regards.

ॐ

-- 
Swâmi Petaramesh <swami@petaramesh.org> PGP 9076E32E
