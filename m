Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4C514FDA0
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Feb 2020 15:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgBBOpD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 2 Feb 2020 09:45:03 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:43691 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgBBOpD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 2 Feb 2020 09:45:03 -0500
X-Originating-IP: 78.245.226.90
Received: from [192.168.38.25] (vau38-1-78-245-226-90.fbx.proxad.net [78.245.226.90])
        (Authenticated sender: swami@petaramesh.org)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 4FE601BF203;
        Sun,  2 Feb 2020 14:45:01 +0000 (UTC)
Subject: Re: My first attempt to use btrfs failed miserably
To:     Skibbi <skibbi@gmail.com>, linux-btrfs@vger.kernel.org
References: <CACN+yT_AYiLc29M41U+WrQHtk4t==D-4AkH+wRROKJY=WstGAA@mail.gmail.com>
From:   =?UTF-8?Q?Sw=c3=a2mi_Petaramesh?= <swami@petaramesh.org>
Autocrypt: addr=swami@petaramesh.org; prefer-encrypt=mutual; keydata=
 mQGiBEP8C/QRBADPiYmcQstlx+HdyR2FGH+bDgRZ0ZJBAx6F0OPW+CmIa6tlwdhSFtCTJGcw
 eqCgSKqzLS+WBd6qknpGP3D2GOmASt+Juqnl+qmX8F/XrkxSNOVGGD0vkKGX4H5uDwufWkuV
 7kD/0VFJg2areJXx5tIK4+IR0E0O4Yv6DmBPwPgNUwCg0OdUy9lbCxMmshwJDGUX2Y/hiDsD
 /3YTjHYH2OMTg/5xXlkQgR4aWn8SaVTG1vJPcm2j2BMq1LUNklgsKw7qJToRjFndHCYjSeqF
 /Yk2Cbeez9qIk3lX2M59CTwbHPZAk7fCEVg1Wf7RvR2i4zEDBWKd3nChALaXLE3mTWOE1pf8
 mUNPLALisxKDUkgyrwM4rZ28kKxyA/960xC5VVMkHWYYiisQQy2OQk+ElxSfPz5AWB5ijdJy
 SJXOT/xvgswhurPRcJc+l8Ld1GWKyey0o+EBlbkAcaZJ8RCGX77IJGG3NKDBoBN7fGXv3xQZ
 mFLbDyZWjQHl33wSUcskw2IP0D/vjRk/J7rHajIk+OxgbuTkeXF1qwX2ybQoU3fDom1pIFBl
 dGFyYW1lc2ggPHN3YW1pQHBldGFyYW1lc2gub3JnPoh+BBMRAgA+AhsDAh4BAheABQkYZsSM
 FiEEzB/joG05+rK5HJguL8JcHZB24y4FAlr/47cFCwkIBwIGFQoJCAsCBBYCAwEACgkQL8Jc
 HZB24y75ogCgqwIQzwpyRpOKyHnlzKoQEagNQDYAn04TrYVf1g3vQifjl+jMawDZtGG/
Organization: Secte des Adorateurs de Cela
Message-ID: <a9069bcb-73d2-09fa-e156-a1a3037303c5@petaramesh.org>
Date:   Sun, 2 Feb 2020 15:45:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CACN+yT_AYiLc29M41U+WrQHtk4t==D-4AkH+wRROKJY=WstGAA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB-large
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Le 02/02/2020 à 13:45, Skibbi a écrit :
> So I decided to try btrfs on my new portable WD Password Drive
> attached to Raspberry Pi 4. I created GPT partition, created luks2
> volume and formatted it with btrfs. Then I created 3 subvolumes and
> started copying data from other disks to one of the subvolumes. After
> writing around 40GB of data my filesystem crashed. That was super fast
> and totally discouraged me from next attempts to use btrfs :(

For what it's worth, I've been using BTRFS for 5+ *years* on removable,
encrypted hard disks, and use them daily on Raspberry Pis with 4.19
kernels and *never* hit a single problem.

The only time I lost a filesystem whas when I got hit by the infamous
5.2 bug, and it was on a classical laptop, not on a pi...

Kind regards.

