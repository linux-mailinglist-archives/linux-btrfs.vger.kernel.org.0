Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4731F2B2FB5
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Nov 2020 19:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgKNS3b (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 14 Nov 2020 13:29:31 -0500
Received: from mx.kolabnow.com ([95.128.36.40]:48714 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbgKNS33 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 14 Nov 2020 13:29:29 -0500
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTP id 9D85E40D47;
        Sat, 14 Nov 2020 19:29:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        references:message-id:content-transfer-encoding:date:date
        :in-reply-to:from:from:subject:subject:mime-version:content-type
        :content-type:received:received:received; s=dkim20160331; t=
        1605378567; x=1607192968; bh=C1h35EUW6RKLuCWezouUxwO/lMt8TLE69Xj
        3j2HhrcA=; b=4NHl5+ioAfgO+7na45txVFJK8DkibZVHAuEhYUSWZwgmrj+U1i7
        z9oL/Ll93LaHRgoe01NH+yNKbe7HoWQvTQQYVMd2GMh8F7pktjvVypgmhsPOmZja
        O5HFDBdFdBkSP7+qSIQzZ1YlyrVSF6uKwpoLGOCjjXRdWzg5fI930+T3+riyFZc5
        VolVY0BT2S/PZQnjK4aDf4KtmflSGcdU2QOMYn+RGkVpPT9d7NPhJfRthCMUhSe8
        VOH2CpcyxFr0DjmXkRhO34sOYYMpsr8oizSyWiQiwjg9hO3f9L7lcikZ/spNyCpX
        qIYPm8VZXsjnVl78YZRwF8ss5QiAwsTQK5LcLjkSS+3C9lux46hcE/ZxXlBZukYN
        iuNz/sFWCCAsrZ23ZWZVGIOrWQaPcXafiPJgExximRxRMM2DouK2hXPi1l37ANW0
        9scG89TgtjvE29qswp6WXgCdkg6SJYKpNuu7eIh5hUB8OeBirNTVZaIZ4scHswEz
        zRwFCoUR9F30zD7I7cJFpyl+Y0lb2gmBsFfaTHj8MogZoHRaU6PvuEK03m/3PW5h
        kSHKEkYkPSjdkHHlg1a52twhUnvIzd56WOcYXgpzwG1DOw51Yu1egX+aTh99GbGz
        X6TAUvkhsJBGfnw6Aw3yLALUG4Lsz5Dv0duRxUlu/ujBTrMDlFKC76ls=
X-Virus-Scanned: amavisd-new at mykolab.com
X-Spam-Flag: NO
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.899 tagged_above=-10 required=5
        tests=[BAYES_00=-1.9, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id issAl3ks6gXZ; Sat, 14 Nov 2020 19:29:27 +0100 (CET)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id 05852403FD;
        Sat, 14 Nov 2020 19:29:26 +0100 (CET)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx002.mykolab.com (Postfix) with ESMTPS id ADD93286D;
        Sat, 14 Nov 2020 19:29:26 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.40.0.2.13\))
Subject: Re: bizare bug in "btrfs subvolume show"
From:   Lawrence D'Anna <larry@elder-gods.org>
In-Reply-To: <CAJCQCtSxFH0CgoDm53BsqUMymkf2NnwiMwFbN+VBsXvzJe5YLQ@mail.gmail.com>
Date:   Sat, 14 Nov 2020 10:29:21 -0800
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5285DC28-F5E8-4FD8-8DD3-67245D7202D6@elder-gods.org>
References: <61E331A6-9DA8-4A7C-905E-4B5A17526020@elder-gods.org>
 <CAJCQCtSxFH0CgoDm53BsqUMymkf2NnwiMwFbN+VBsXvzJe5YLQ@mail.gmail.com>
To:     Chris Murphy <lists@colorremedies.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



> On Nov 13, 2020, at 11:28 PM, Chris Murphy <lists@colorremedies.com> =
wrote:
>=20
> I can't reproduce the error with kernel 5.9.8 and btrfs-progs 5.8.
>=20

The problem seems to be tied to a particular filesystem.   If i try it =
on another filesystem on the=20
same computer, it does not reproduce.


