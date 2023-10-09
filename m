Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603747BD1FA
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Oct 2023 04:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344984AbjJICey (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 8 Oct 2023 22:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbjJICex (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 8 Oct 2023 22:34:53 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89557A4
        for <linux-btrfs@vger.kernel.org>; Sun,  8 Oct 2023 19:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
 t=1696818889; x=1697423689; i=quwenruo.btrfs@gmx.com;
 bh=VSFFd33vSolCE/1Ab3VqIZPBLwzR0dVEcOOb5khS298=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=O8Atk66WyBC2VuyLjaNDer3l4+aFq5n7dZdBNyxoDyTfz+J6PhYTIBv8IFT+G4cV8LKGDY1KfdR
 CxCJlcDuQH4X63LQuQlTk3vfROK/uNiztJj1Ftj6L4FEz7LBCYDPMu2ytSe8vEmCTKM8GaOXUr7oA
 +ACkqfWQ1siA/+KUY83hNe6zoz8jTbifOTP9+rTPuM62TCvpbilXGeNTvHofczASo8aW1kuJplp6i
 qyUNkwL+dcPXzKF7DYkrGxVjZ0BO8IlXFzayvz3PNDP64KvBMWDKYv6r1Af/tOEK9Ar61u1jWYwPJ
 7Lwzbbg7srp9bxcI7TSBTU1toTTCtID4FOOQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([218.215.59.251]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N79uI-1rfQiy1etI-017UHF; Mon, 09
 Oct 2023 04:34:49 +0200
Message-ID: <cb305aff-1d8c-4ec4-a8dd-330ab96169f2@gmx.com>
Date:   Mon, 9 Oct 2023 13:04:45 +1030
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: qgroup: check null in comparing paths
Content-Language: en-US
To:     Sidong Yang <realwakka@gmail.com>, linux-btrfs@vger.kernel.org
References: <20231008091717.27049-1-realwakka@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <20231008091717.27049-1-realwakka@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bH/8slZD9mlo6kttuet+QAv74YDCRSDGhM0U9FNpL1c1TcVnBsY
 n4ZMsB+4d3aPHiNTNuD4bYCrlif7UrxAjDeGGXN23X8xzXwW20tdgpRK2WYiX3/aSqf3HZ1
 /O9niZDKFo99T80xPzkS21lE3PyvUbPod3hU1fKlehZFAili0DKRhnv0mrnwbritkmbNXrE
 xS6Y6GqXZW+sjYKh5tafA==
UI-OutboundReport: notjunk:1;M01:P0:7t3AgN4uT6s=;5Rw67x1TkNCAouZpHJTpEKsSMWT
 6AZCst52d2r/hfXryQYbZw5ilIDz0p1yf6jHSFfhatyf0uUnn2XTe8gAoUHF+o54fEmBbVJ+9
 ChRM/76XkjHCO3hOpZPxfL+wmAcz1hOO++cidqgeEkRuAgUNxWeg8RJAwe2JwjGibhmwwhsFp
 aI4DAj6sVqW369f0Ie2iMYenXg1tZ8WkqMvg2L85RxsHz96TdtwJ5wGhb6yyk3Hlf6AhiEpdj
 fUrWxVBL1oV4KWIG8SRBXc+N8PHrw15Fh8lcQD12nTaX8ATcgJIaG8F/lG8ljKaWaDCr8gtkP
 DQ1dFpiq2t1UgwoXg+3hqfvc6wBxcc88bC2+gSlXaQ5uPfZ6Pz2hCTnOzkyrbJyugZHcOcmls
 SgRkjHZcm38g/aFfA7FKA4o2HSYa9dgElT6CILkrhD/tcSkpJnZ9MiphXRoYdnUg3XusNjfhm
 49lpSMzS9ZNyZ0Ir8l+iYByYMwC6tJZQwwpA+wOA1h39XRCELoprHeHiNmWsUlXOSldPiQCu7
 a3BWpbq8V86QLM87ZM9oo545PIJ33OIkbsTVEij6yTwmlHjoIAmOSxtRpkgq1ogoCmGI81Yr7
 tH+GM77jyd4VsMd/6fB81g711RrWKwxtL1jzt6mT4ceWth4+w9NzhzGK15abCoas6mMmh+ibk
 4Yvi9b8nUG0z8eHFoqtg6xn6HX/CuC4f5kacXLRnWaSYbNupxLKft2xo81XMsUtZubEu3sHIV
 pcIQqzKBqsxZGNisfgWeYYxyglfeW8464nrOxD667GNjxL9rxCHU3jR02vGx6I1EGKqrJYNc8
 a0pSAn/wrScrnrOL2EjhmmU/VBNJ84F/0NSp/sVQ1B9yu1ot2a+jmD5AgLYwd9A+zPqhY4NDA
 jr7xOFKmArUCkcSrOqH1fj0k62KW+2IRaU4UGf4Cs77815N8oPEXRfJ2Um3/yI7VWz+JWvWCU
 eEtR9sKQR/2Q/AVUta0/SICzt/M=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/10/8 19:47, Sidong Yang wrote:
> This patch fixes a bug that could occur when comparing paths in showing
> qgroups list. Old code doesn't check it and the bug occur when there is
> stale qgroup its path is null. This patch checkes whether it is null and
> return without comparing paths.
>
> Issue: #687
> Signed-off-by: Sidong Yang <realwakka@gmail.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

It's also a good chance to contribute a new patch to add such test case
to btrfs-progs.

Feel free to ask for any help on creating such test case.

Thanks,
Qu

> ---
>   cmds/qgroup.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/cmds/qgroup.c b/cmds/qgroup.c
> index d9104d1a..265c4910 100644
> --- a/cmds/qgroup.c
> +++ b/cmds/qgroup.c
> @@ -486,6 +486,14 @@ static int comp_entry_with_path(struct btrfs_qgroup=
 *entry1,
>   	if (ret)
>   		goto out;
>
> +	if (!p1) {
> +		ret =3D p2 ? 1 : 0;
> +		goto out;
> +	} else if (!p2) {
> +		ret =3D -1;
> +		goto out;
> +	}
> +
>   	while (*p1 && *p2) {
>   		if (*p1 !=3D *p2)
>   			break;
