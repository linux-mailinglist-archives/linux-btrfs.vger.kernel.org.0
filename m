Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E62DC2B3107
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Nov 2020 22:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbgKNVfx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 14 Nov 2020 16:35:53 -0500
Received: from mx.kolabnow.com ([95.128.36.41]:21048 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbgKNVfx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 14 Nov 2020 16:35:53 -0500
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTP id 0195C7A6;
        Sat, 14 Nov 2020 22:35:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        references:message-id:content-transfer-encoding:date:date
        :in-reply-to:from:from:subject:subject:mime-version:content-type
        :content-type:received:received:received; s=dkim20160331; t=
        1605389749; x=1607204150; bh=+VfLLGKbugc4Mpp+n/BljOHeRKGaAbw3jke
        o332KQ1s=; b=4dbkwrMxdmzu10rBTT80CvUMQ5g4URv7z/2W3bFkDBPBDf/4P99
        DyTKc0J9sczkg67IRrObRiv58V9kw7hKzLYrNeGE2nD606cs9PD+kWyinOKOJyw2
        fScsmp5iKP9gaGEyNOeeOHvUq5rC4DRJ0yeAiZnLIrz313LVXeG6NyQmtzPmnqgG
        cPFcDqSSH+zpZNvJB8/Jx+BIv/yVEeMxXDLMFBPrV412WIva5t/xwXkcPBVEQWIk
        QiaCRJyJxngxDxFtgro0dl/eHPAw2lcARGY9AhSIoIAfmKBM4LrsIeBgUJC9Rqxj
        35CLQfngUsZF53Nk6Zhv77lNHOeuL2O6NdRpQZSqFbQqiWGptMnv399V847Tnu8n
        nnE1unbANzt/we9gGHDuU4F9o+q5KJxknMTzACcDkfRMMt+Q4XB/nd8QjLF29BTv
        FzvEbM28sLP2H4EQLLiL1h2fb4HymaBW/IJNHZYXloNqMxNvP12ylwcRyXGNnwfZ
        zmJ2ITLdRD2cyPkwPktfVlB3KUF+H8SZhg76G90an3uQay4tqToyvx4YU2SSJCn1
        93aGa85oXxlG3znUfjyl7DA8p8SJydVR8iii+36cLx5+m3fOKOglrpb4eG2p92T5
        G0jda6iSAysntTxo8++ao1Qve+/BVql7Ntvr3m6yEeswI6WtGyvlKaHs=
X-Virus-Scanned: amavisd-new at mykolab.com
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 tagged_above=-10 required=5
        tests=[BAYES_00=-1.9] autolearn=ham autolearn_force=no
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KmDo8hxAQ1k5; Sat, 14 Nov 2020 22:35:49 +0100 (CET)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTPS id 6010A4A3;
        Sat, 14 Nov 2020 22:35:49 +0100 (CET)
Received: from ext-subm001.mykolab.com (unknown [10.9.6.1])
        by int-mx002.mykolab.com (Postfix) with ESMTPS id F2E47201E;
        Sat, 14 Nov 2020 22:35:48 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.40.0.2.13\))
Subject: Re: bizare bug in "btrfs subvolume show"
From:   Lawrence D'Anna <larry@elder-gods.org>
In-Reply-To: <61E331A6-9DA8-4A7C-905E-4B5A17526020@elder-gods.org>
Date:   Sat, 14 Nov 2020 13:35:43 -0800
Cc:     Meghan Gwyer <mgwyer@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8EFE06A3-9CC4-4A6A-850F-C7C57DC27942@elder-gods.org>
References: <61E331A6-9DA8-4A7C-905E-4B5A17526020@elder-gods.org>
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


> On Nov 13, 2020, at 9:47 PM, Lawrence D'Anna <larry@elder-gods.org> =
wrote:
>=20
>=20
> But I haven=E2=80=99t been able to track down how redirecting the =
standard out is possibly influencing this.

I have narrowed it down a little bit further.

cmd_subvol_show uses btrfs_util_subvolume_iterator_next_info to find all =
the snapshots of the=20
subvol it=E2=80=99s showing.

while it=E2=80=99s performing this iteration, =
subvolume_iterator_next_tree_search returns a subvolume id=20
of 7168, which does not appear in my filesystem according to "btrfs =
subvol list=E2=80=9D


