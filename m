Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A24ECCF0F8
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2019 04:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729849AbfJHC5X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Oct 2019 22:57:23 -0400
Received: from sender3-pp-o92.zoho.com.cn ([124.251.121.251]:25824 "EHLO
        sender3-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729663AbfJHC5X (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 7 Oct 2019 22:57:23 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1570503412; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=ngWv5qgLiORULTzmLPcC5Kv3KwQCaRQL+5Rsp1tuTkpAkM7QEDRoirR6KyI9OMNsaobTnXyhOjUeLiQoZmYdN7PLnsvAD1Bvez0UD6WUeu3rNDVTnYJZmi8nquMTjWBlieJF22fpA/vkt7PUpMNRZhYKZ0qFIqBDOnEpop4MXHU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1570503412; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To:ARC-Authentication-Results; 
        bh=e5pMaJvXNsJ4gLwtVkq5uTM/6U77Oyv3p9DS1fh/gmg=; 
        b=cI3kha0eQD+Bel6+g5xUGwHRKeePNL3Shs9+sTbAvxSof/iAChwcai8ZMdPix7Az2RC3FWFTAUHy48/WVQqjNlYzyIqhrRq2QTKf7ZRG6KNdQv55UILQkCRfEJbeNImkk43alUbQfhCG/HHdR38TKRlbLwtHO2/CkC4PMlnRm8Y=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1570503412;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        l=767; bh=e5pMaJvXNsJ4gLwtVkq5uTM/6U77Oyv3p9DS1fh/gmg=;
        b=TnigNCtWp+4UmLKBdqZ0zlnXKQoHLNxTqW3DWH4M/BBI7KO2hQuXcZq7zdPs5fqU
        IsdITjjozBhJaDU44VYCZVAOyRWKHTZ4ZZj2p2lwKrRBG84tmbQgZ7Aj6o9mjI2e00k
        XO8ldUa8iBqKVkbEbbu+zTYZewzQpOQmpYEzzV+E=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1570503411109698.9186358481302; Tue, 8 Oct 2019 10:56:51 +0800 (CST)
Date:   Tue, 08 Oct 2019 10:56:51 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "dsterba" <dsterba@suse.cz>
Cc:     "clm" <clm@fb.com>, "josef" <josef@toxicpanda.com>,
        "dsterba" <dsterba@suse.com>,
        "linux-btrfs" <linux-btrfs@vger.kernel.org>
Message-ID: <16da94c45a3.11fdf8eae27262.1375415460905873066@mykernel.net>
In-Reply-To: <20191007154452.GE2751@twin.jikos.cz>
References: <20191005051736.29857-1-cgxu519@mykernel.net> <20191007154452.GE2751@twin.jikos.cz>
Subject: Re: [PATCH 1/3] btrfs: remove unnecessary hash_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Priority: Medium
User-Agent: ZohoCN Mail
X-Mailer: ZohoCN Mail
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=B8=80, 2019-10-07 23:44:45 David Ster=
ba <dsterba@suse.cz> =E6=92=B0=E5=86=99 ----
 > On Sat, Oct 05, 2019 at 01:17:34PM +0800, Chengguang Xu wrote:
 > > hash_init() is not necessary in btrfs_props_init(),
 > > so remove it.
 >=20
 > The part that explains why it's not necessary is missing in the
 > changelo. And looking what hash_init and plain DEFINE_HASHTABLE does I
 > don't think that removing hash_init is safe or making the code more
 > clear.
=20
Sorry for pool explanation in change log.

Look into the code,  DEFINE_HASHTABLE has already included initialization c=
ode in it and
I think this is the main difference compare to DECLARE_HASHTABLE which stil=
l needs hash_init.


Thanks,
Chengguang

