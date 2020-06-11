Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8FB11F6982
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jun 2020 16:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgFKOBG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Jun 2020 10:01:06 -0400
Received: from mout.web.de ([212.227.17.12]:34367 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbgFKOBF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Jun 2020 10:01:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591884023;
        bh=c56enI6I5/M+hosAuiztGDVYwFDAzlVT7WCsV6L+sCM=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=KgWjtK8PNT5R9gJvAsYXE3kcsV/2aRG5XIZv4MZ7gRgPRDXcdS4JXhsR6wL5UDlim
         5ImsUVNHvMdC/rOd/T/xxez8VqWZ1zREZw2TytgPhOqnRq9lHJJtzPVgRwFKyCOqwr
         5KHUXaqYfs87CzeHxB/etJTLcEIIi0izkojoMOMU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.66.14]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lk8ko-1jBxsb2bne-00c86P; Thu, 11
 Jun 2020 16:00:23 +0200
To:     Liao Pingfang <liao.pingfang@zte.com.cn>,
        linux-btrfs@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Wang Liang <wang.liang82@zte.com.cn>,
        Xue Zhihong <xue.zhihong@zte.com.cn>,
        Yi Wang <wang.yi59@zte.com.cn>
Subject: Re: [PATCH v2] btrfs: Remove error messages for failed memory
 allocations
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <59c4741e-5749-4782-33f8-cc3a30ecf5e5@web.de>
Date:   Thu, 11 Jun 2020 16:00:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IyBTW/gNW38LPjCOjd3Qe1+b51Rw6WxRKknz3xLGxZYik08By87
 TzcVUBZIMxV+L0ZZlSsHJZ3+X4wjZxL04qgkr2FwNeVTLbcKOx0g4eFjUkIHZwJjwvsqFKb
 vNRv5osIGhKAfYDBM/lB8DBQef32AATkJT4qkKcMFYtTnFshCgBr941TeUn8XDCYSkXfJud
 vRjmYAO9KSBmLWK1SLXDA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jydVKnpGdc8=:ITOi9FeAOKR5INVh5etx1C
 TrSe0K8in77gqCiHKZzPi2850ugX99H90uENMoKzWZwxSGAAUOx5sOquWH1E9d/aEpmB5tMVK
 A0GOZ7161LBtuv02g21SZowRujxCbzyqkl0pP/CCaSxRI47lc5PCrL7YGZ7M816R21C6uZNSW
 Zs2ILkEhpAaRaQMJT7qKpeVeiCVEYmS5QIp2+zL9cEPdXliolNLxZrCbMm2RPNuJhpAHb+kVl
 XqhQJn0kfxSFSWGR5YcAka1MS1pYDkybw3JNbHXN9Ai/PX46jk7XtJxxh7GZb5+C3Pqw807T9
 bnOOTlxTdSPFel1aRzBN4ZDP1SxojS6l4ZiuI+MWMOQD9GV7fYmufxtxztSySH/GiqU+BXG4H
 0NKjpSdf530k2KiQClya6Rc4Jbe0In0DEUMcD8bCrupRVZxEUN9ojNZ4NGrN9gyO9eqemWE1+
 uhNBFi7vgrpcJde7mOpAYlrQQXqMo0n8qCLEg+uKy4aQwoOz2pqOT7cBEdmvl1oz3lo1daxxn
 msJuJOBJV3D37chv7YiN/41DzCGKdX5yTh4mq6adQcyjTEPgfPvB5zdhleKFNYuaCma32Ioex
 qVDT5lMtSxpax6fHPXp91JU9PCxqTPr9AqzpVWjjRjDBi9XPgo1PIY0Tf5relFpQBhfM80K2Z
 RsoktbuXVdqAaeI8S5vBZZbOnUF2iYroSKNkFyokXsqSCyK/J1RoZT9J5fxsLSXq8HuEAdcFE
 TkAWsnptAd9pJHXTWutsaRXkFxg4aaS+A//PL14geme4EMh6IjriHNJF6tAVNNFtCKyDvyN6h
 oYBr33ll4b8276fwB+VpDSfuB89rGzQy7GsrMUB/gR606HXqpIGnfmKv2o4oaKZc/UXtJtz32
 HgBsVKUhYzLlm/YtuskTDXHyajzu/2oGUXjSCAJ/cMRJwST29IWp03J4kfyZE+JXs+lniEkCf
 nNjIkoMnEPNySl0jH4X7DjQPRNfWQd96EXElovXTWZ3iKOg5OqEJfqkDS5SEX95kGNwJug2Ie
 AgkRRNii2+I/talebMlmyDZyDRQtyDD5koXJlcOUtL4j+aCuQ/XL7/ML6QaPSzSomiexYG2Es
 bgdnvVgZKh7il8RRc1h+7O+TYT4DJYGhhEl/tyArMpX/fvJyWAEkfEl4Fx8OeQsyCupUm2HFD
 MuiNYZbemLk7LdfLdDFurHK948sdl1053Qpjx/VVuO/rPEwdQl/Vaz+YQRgI+DBV7WMde0Esf
 OWNOz3kQsgq0zNRWM
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> As there is a dump_stack() done on memory allocation
> failures, these messages might as well be deleted instead.

* I imagine that an other wording variant can become clearer
  for the change description.

* I suggest to reconsider the patch subject.


=E2=80=A6
> +++ b/fs/btrfs/check-integrity.c
> @@ -632,7 +632,6 @@  static int btrfsic_process_superblock(struct btrfsi=
c_state *state,
>
>  	selected_super =3D kzalloc(sizeof(*selected_super), GFP_NOFS);
>  	if (NULL =3D=3D selected_super) {
> -		pr_info("btrfsic: error, kmalloc failed!\n");
>  		return -ENOMEM;
>  	}


How do you think about to use the following error handling instead?

	if (!selected_super)
		return -ENOMEM;


Regards,
Markus
