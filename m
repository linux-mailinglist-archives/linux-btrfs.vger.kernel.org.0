Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C78D511FAE2
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 Dec 2019 20:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbfLOT4Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 15 Dec 2019 14:56:24 -0500
Received: from mout.web.de ([212.227.17.12]:51829 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726146AbfLOT4Y (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 15 Dec 2019 14:56:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1576439769;
        bh=32HM1dJWyoIgCVFimPslKrXh6th5qj5mlVrqvchIwlk=;
        h=X-UI-Sender-Class:Cc:References:Subject:To:From:Date:In-Reply-To;
        b=bOlPrfO11Bl7l7ZuxDKIh/JhhPAo+iB1Nem+r15ceLnSCzjlvzn8ADExhnBhPir5I
         fZhHcPwaCEXPWKzuSDShrgybdOAucvJ5J8iQMgJt1kLlXRf812NF7twyFnyP42MHH1
         8FuMNbenIB+xDb7vr2v+d6fKaQ6KGnFVrxypEogc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([2.243.76.50]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MT8o6-1iEczn0JL4-00S9Er; Sun, 15
 Dec 2019 20:56:09 +0100
Cc:     linux-kernel@vger.kernel.org, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Kangjie Lu <kjlu@umn.edu>
References: <20191215173226.29149-1-pakki001@umn.edu>
Subject: Re: [PATCH] btrfs: Fix incorrect check
To:     Aditya Pakki <pakki001@umn.edu>, linux-btrfs@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <944244bb-92c5-2c71-84de-ec5e402ecd24@web.de>
Date:   Sun, 15 Dec 2019 20:56:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191215173226.29149-1-pakki001@umn.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:43R6qmdpUatWlOoh4wttmiOoB2gPXQBYLxTSZ4lpjq6e4v+8rhf
 DIh22KDUW+N5PDXSivm+rV7cR14QmSExZ1j7Ps8dgGojDP/lSajyefqZoIdgFgb7YHMG+Ov
 /YUzVm1IOmm82KkXerLKamZvpYyACsKMuw9Q4n31MrfHejTWmmbCGVuoJLDZVvt+2Eoe+du
 KvYhh9N8xhWAE0QaIOqjw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:scqL3Bn7x9U=:/Hz2LNb3h+GVjGLCgBdjD6
 fMQNybLLbeblxuTtXPLuMYq9GG4GI3gnleEB4wiHSNRgX7DsD5xPSBiAkC8UQPoOoAiHLl60q
 4N4397Af075QpPaTCWuZ7/wtcfWRXWs3wjfB1DMNEk4t4bfa1VAvhKl15aMHDu8X6wpMBw8Nq
 N2tFvxPVTjAmtGkS+ORbZQAhYb6DGKp9m8NVhQ+mPkPV8jK438WsZ6dSkI3/nNVd+/woWlflA
 w83cv6jtq2/fl9LZYTT5dFB/dVXeE0bYAk2LUaMFdg2PH/dj04MdvNQmk/DqM+low7sUPVt+7
 kr8F72RczCv2xDpvx3YvKBunoEUi9Ttt4Ot3HF4ZYeEGJ13of2zJuMtUeb/2v5oLRuAi2yycC
 lI+u8GndIzMd2HWbpKb5BdV1PFgR21R5XKDp3OLR5jFhr5KxmHu/l6dCh65qxjw64/qY6QKGm
 DA9SAdpC6jFlw5HCmbuDv8yLenP3BG6iwxtQvDY7+iaR09i7CPIu8SQj0Y4TuUXuIe7sijEir
 Bvof8Zd5iNo+gPV29N0szlZOLpWLfnVhdPDkMJUZ6ONvYkSkwIDpN9XDAlB+IN8GRs9gPlhh3
 Z/CaWD4PYgPZKyCdHTbVeRMkk8Zxe9LydeVZuGIR9mq8XgrSAZChxMu2k4z8X2u0L87WFcSyG
 QXZv+tWIZWOyPrN4WjXs8tm67sRKu4X4vwk6U+fKKcWx+d5TtJXwuPeQbcnFZ9z1aqJeAvd6k
 8VYJxmJwF7+sShRT8An3CatBAoYB8jH1Whuz8kz2OQGEQXCiScZPrbqEm78Db5cFGCqXviV8s
 2SN+Nh1W+yUkSNUEdKO3KRaVwO2dXb2T4AZvTNHhUtN8J8MtvuF09kRAAfQBpz2TrsFUg9OWc
 PGDGv4ms1ZfSxW1d7Mb/Smx+HFXt6Ko6QZG1KI23et8WQfR5VRsRLyWJxDAjRECrSP8XIMNEW
 OsFJDXgUEHlJmLZp3fKQIK+BKUvTetdiC2K6xTIgyK6RneeKaILmGY2CJ0gjK1XmUVKOgcNFk
 AZKQa1Wegojtg5JptpaEKLf0qIQhWdMOAkir93pBecO53b4ETarPw5wBvLNymy+FuF4vT3s+j
 CuIcU+ok2nHBVhI1Hihm1gelTuXvypkNFgRIqa7GxJIvb+myYLZTUVfuDOYEee0RHCQejksru
 Zlk/TF6BiTcsTV7bNaVUazkTsASo5+p14Nif8lZPa1qVdntG7/kf6h/CbXjsxbvzDQD6Jt/Zc
 ZvKmHf9iWC2zPYXIA4kG4wMI0ndLkdbQP2rLgXFL8jhb0+eubHyRBvtS0IHGC3qhX+zQxQ0kq
 NBTrrzTrhbPllwRDHF8VCyEU/4JPjyggzuII0jkvFxyMeJGVgJeq+/ltmAh/crIqErocd4xlV
 nHpB58p3uBkc63XisVAg6dtVGH5C0u7WXu+eY48r5roHuX/7l358s3pjLHHPk+sUCsTBj4xks
 xerv0P8nfJR5Oe7RCjnvzs9msQ+nhwCEbNpylMQN6OQk7SAGrDDkChLvl/5XQ/frSxcXUNu4u
 V/8PFcbbt65u8ymi/sGeq5qVEDatzph9gQHVvm5bC2jyf
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> The patch fixes this issue by returning an error if state is NULL
> and then assigns fs_info.

Please improve the change message (besides avoiding a typo in the subject)=
.

Would you like to add the tag =E2=80=9CFixes=E2=80=9D?

Regards,
Markus
