Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D22AA2B533A
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Nov 2020 21:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbgKPUwI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Nov 2020 15:52:08 -0500
Received: from mx.kolabnow.com ([95.128.36.41]:54486 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728574AbgKPUwI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Nov 2020 15:52:08 -0500
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTP id C7300B25;
        Mon, 16 Nov 2020 21:52:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        references:message-id:content-transfer-encoding:date:date
        :in-reply-to:from:from:subject:subject:mime-version:content-type
        :content-type:received:received:received; s=dkim20160331; t=
        1605559925; x=1607374326; bh=wYyfj2Uvmky2mjUZmZCpP/JpGRYHEsCcUhP
        FD5w2lNY=; b=zP+r2F+LUr557t0KMdC/snNFMLqfd1l+oZorCfuYiNBow7Oqu88
        MbJ++yUa1Lk9ZgHDvSPJRncFMiVFnGasYtAOsgotalFg53a35SmKtg+7BVyrejBd
        Z7bilBiKWTM4+QRGSraWCQSEUQXvxJuFKr1DGMWqG/NxTi3pr9e5bI4RmwKivpK8
        SH7C/w6/BKA4Et8n2nhXTA1boCrns1g+RtZOuPIwz3fHBgdehGL3FUUT31WqmyWC
        n8g/PHuzk3QbKu45w68ksubAJICm21UVDSH0OACbC0jK9DkPlr/J1mhHEugUcNJK
        tRMRRWk/gn+QnFPP2ucPWvf/b2rVC0LhBWsZl7SKKcYW7QCjzWjkc05P1XwMZkE6
        15mI6eg0gOyMYTypnWXNRx7HLqkAIqxWCoDOxM9q9mzhb+uSC5kYO6goAHn2rJuQ
        CYHDnYpAdk/X8KM7YabaEgrsbtej7J/THRhqta0ahlwQYCtFEFBmGofcdVJuuSZb
        rHxaNMbp8VjGxXEgsaJD368SCPUZNc28oT/tLkP+cZBW3oElEa7W0tCi4q+OAt1U
        JXjxKd3KlVRUIcwALJgNigZS1B/vM/u0mc6swNkDn1gIlN+VdQZREMkwYdi85oLT
        qhK5bgA18UCEXyAVtWnyrtYT+TZdGf63Nvjh2UJvGS5qzcRJSnOSkz6M=
X-Virus-Scanned: amavisd-new at mykolab.com
X-Spam-Flag: NO
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.899 tagged_above=-10 required=5
        tests=[BAYES_00=-1.9, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id exh5N4UNPUNG; Mon, 16 Nov 2020 21:52:05 +0100 (CET)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTPS id 305B26AF;
        Mon, 16 Nov 2020 21:52:04 +0100 (CET)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx002.mykolab.com (Postfix) with ESMTPS id B99E5233A;
        Mon, 16 Nov 2020 21:52:04 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.40.0.2.13\))
Subject: Re: bizare bug in "btrfs subvolume show"
From:   Lawrence D'Anna <larry@elder-gods.org>
In-Reply-To: <e954d760-28c1-9491-cd60-8e7dfc626ca4@libero.it>
Date:   Mon, 16 Nov 2020 12:51:58 -0800
Cc:     Roman Mamedov <rm@romanrm.net>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Meghan Gwyer <mgwyer@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3612C07A-0872-401F-89D9-E9DFA9C9D0C6@elder-gods.org>
References: <61E331A6-9DA8-4A7C-905E-4B5A17526020@elder-gods.org>
 <8EFE06A3-9CC4-4A6A-850F-C7C57DC27942@elder-gods.org>
 <20201115145323.1628d710@natsu>
 <C20FAB48-98B0-49AE-B804-FC720E31C5B0@elder-gods.org>
 <e954d760-28c1-9491-cd60-8e7dfc626ca4@libero.it>
To:     kreijack@inwind.it
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



> On Nov 16, 2020, at 12:31 PM, Goffredo Baroncelli <kreijack@libero.it> =
wrote:
>=20
> Definitely it is a strange behavior. The value 7168 should be the =
wrong one because it is out of order.
> Are you sure that this behavior depends *only* by the redirect ?
> If you ran "btrfs subvol show /data/" several time, you always get the =
same (good) value ?
> And if you do it with a redirect, you always got the wrong one ?

yup, it=E2=80=99s very reliable.   Every time I do a "subvol show=E2=80=9D=
 without redirect, it works.   Every time I redirect it to anything, a =
file,=20
pipe, or /dev/null, it fails in that same way.   I=E2=80=99ve tried it =
many times at this point.


> You have a raid10 profile, so an explanation is that sometime you read =
from the good drive (where there is the value 7290) and sometime from =
the bad one (where there is the value 7168).
> However this should be impossible because
> 1) the metadata is protected by a corruption by the checksum (may be =
the checksum is different in each mirror ?)
> 2) and it should be not strictly related to the redirection. The =
mirror from which the kernel reads is decided on the value 'pid % 2'.

yea, I did a =E2=80=9Cbtrfs scrub=E2=80=9D this morning and it found no =
errors.    Absolutely bizarre.


