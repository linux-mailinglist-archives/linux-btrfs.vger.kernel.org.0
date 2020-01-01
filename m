Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49AE112DE71
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jan 2020 11:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725790AbgAAKFE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 1 Jan 2020 05:05:04 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:54805 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgAAKFE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Jan 2020 05:05:04 -0500
X-Originating-IP: 78.245.226.90
Received: from [192.168.38.25] (vau38-1-78-245-226-90.fbx.proxad.net [78.245.226.90])
        (Authenticated sender: swami@petaramesh.org)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 4D46E1C0007;
        Wed,  1 Jan 2020 10:05:01 +0000 (UTC)
Subject: Re: repeated enospc errors during balance on a filesystem with spare
 room - pls advise
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Ole Langbehn <neurolabs.de@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
References: <495cfb98-7afd-a36d-151b-d7cc58f1d352@gmail.com>
 <7461874b-dc8d-4939-c4ae-fbab486750b3@gmail.com>
 <20191231225848.GI13306@hungrycats.org>
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
Message-ID: <015942c2-1bf8-00a5-5091-f967c7db999d@petaramesh.org>
Date:   Wed, 1 Jan 2020 11:05:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191231225848.GI13306@hungrycats.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Content-Language: en-GB-large
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi list,

Le 31/12/2019 à 23:58, Zygo Blaxell a écrit :
> A full balance includes a metadata balance.  The primary effect
> of metadata balance is to temporarily reduce space for metadata.
> Reducing metadata space causes an assortment of problems for btrfs,
> only one of which is hitting the 5.4 free space bug.  For all but a few
> contrived test cases, btrfs manages metadata well without interference
> from balance.  Too much metadata balancing (i.e. any at all) can make
> a filesystem truly run out of metadata space on disk--a condition that
> is sometimes difficult to reverse.

I however was hit by the "dummy zero free space condition" using 5.4 on
a machine, and the resulting filesystem (on an external HD) then still
showed 0% free using a 5.3 or a 4.15 kernel on other machines.

It however passsed "btrfs check" without any error.

The thing that fixed it and returned it to a « normal working state »
has been running a "btrfs balance -m" (on the 5.4 machine) on it.

So I'm a bit puzzled reading that metadata balance is useless when it
precisely fixed this issue on a FS here.

Kind regards (and best wishes for a happy new year).


