Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBF113766D
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2019 16:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729065AbfFFOWh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Jun 2019 10:22:37 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:64232 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729042AbfFFOWg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Jun 2019 10:22:36 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190606142233epoutp039312b2d8cebade85fd0f8b595c7b32fa~lofzikUQZ1588515885epoutp032
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Jun 2019 14:22:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190606142233epoutp039312b2d8cebade85fd0f8b595c7b32fa~lofzikUQZ1588515885epoutp032
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1559830953;
        bh=o26+u579wDsd8MOvWNPCpXlg+PYIMQU4Ow6RM7p975c=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=TH/8VoQzYaXX+wk7+1mrGZcUkwtXLZDLPRniSYALcnf/ORVrYGuOPQT3rquBGT1kA
         9sqCI0uFymXryZu069ag4J3ZszXLIROTdCsPhKY9feROAz/4SJntZHLA9uYXGVj5lV
         7R0X+hVu3bfcuetkVR5S4KoGCIjat98PC3NyTqYk=
Received: from epsmges5p1new.samsung.com (unknown [182.195.40.192]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20190606142230epcas5p393c19e211d4324b8c8c8291a2b3b2b13~lofxDsG6k2622226222epcas5p3m;
        Thu,  6 Jun 2019 14:22:30 +0000 (GMT)
X-AuditID: b6c32a49-5b7ff70000000fe7-f4-5cf921a6715b
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DB.03.04071.6A129FC5; Thu,  6 Jun 2019 23:22:30 +0900 (KST)
Mime-Version: 1.0
Subject: RE:(2) [PATCH 1/4] zstd: pass pointer rathen than structure to
 functions
Reply-To: v.narang@samsung.com
From:   Vaneet Narang <v.narang@samsung.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>
CC:     Maninder Singh <maninder1.s@samsung.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        "joe@perches.com" <joe@perches.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        AMIT SAHRAWAT <a.sahrawat@samsung.com>,
        PANKAJ MISHRA <pankaj.m@samsung.com>,
        Vaneet Narang <v.narang@samsung.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "terrelln@fb.com" <terrelln@fb.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20190605143219.248ca514546f69946aa2e07e@linux-foundation.org>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20190606141019epcms5p1e9c394d2c2ef37506c8004fe48edd29f@epcms5p1>
Date:   Thu, 06 Jun 2019 19:40:19 +0530
X-CMS-MailID: 20190606141019epcms5p1e9c394d2c2ef37506c8004fe48edd29f
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBJsWRmVeSWpSXmKPExsWy7bCmuu4yxZ8xBovXaFlc3J1qMWf9GjaL
        Sf0z2C3mnG9hsbjwo5HJYvHv7ywWW/eoWnS/krGYff8xi8Wfh4YWZ7pzLS49XsFucf/eTyaL
        y7vmsFkcnt/GYnHvzVYmi1f/rrFZHDo5l9FByGN2w0UWjy0rbzJ5rDuo6jGx+R27x7YDqh4n
        Zvxm8fiy6hqzR9+WVYwe67dcZfE4s+AIu8eEzRtZPT5vkgvgicqxyUhNTEktUkjNS85PycxL
        t1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAH6TEmhLDGnFCgUkFhcrKRvZ1OUX1qS
        qpCRX1xiq5RakJJTYGhUoFecmFtcmpeul5yfa2VoYGBkClSZkJPx8vl+9oLbEhWTV7k3MDZJ
        dDFyckgImEisWt3B2sXIxSEksJtR4vqZZqYuRg4OXgFBib87hEFMYYFgifl/MkDKhQTkJI7f
        2M0IYgsL6EicmLeGEaSETUBL4mNLOEhYRCBE4s7HCywgE5kFnrFKHDi/hRViFa/EjPanLBC2
        tMT25VvBejkFvCUWfK+GCItK3Fz9lh3Gfn9sPiOELSLReu8sM4QtKPHg526wVgkBGYldb8VB
        VkkIdDNKTDi3nBXCmcEocar3DVSDucT5k/PBbF4BX4n504+C2SwCqhJLGz6xQgxykbj4lAck
        zCygLbFs4WtmkDCzgKbE+l36EFNkJaaeWscEUcIn0fv7CRPMVzvmwdhKEucO7mSDsCUknnTO
        hLrAQ+LR2jZoIE9nlpi64hDbBEaFWYhwnoVk8yyEzQsYmVcxSqYWFOempxabFhjmpZYjR+4m
        RnAq1/LcwTjrnM8hRgEORiUe3hlMP2OEWBPLiitzDzFKcDArifCWXfgRI8SbklhZlVqUH19U
        mpNafIjRFBgEE5mlRJPzgXkmryTe0NTIzMzA0sDU2MLMUEmcdxLr1RghgfTEktTs1NSC1CKY
        PiYOTqkGRvMjX2/oip50mrshhvkaw9VntaX19+dsefYnpOTEZ77Oom6RA7r/lV4ds3HJ57jK
        oH60zfr8ZtXwrWXbbi08YmHxmoH3RJHJyk2q5xt7Ds4uXnxAc56URU2Ytb+oymax/YytIp7x
        ImJfDY/Jc51dtHz9xPXZPn7fDptenbLz1Ow/e8tOMNlt2aTEUpyRaKjFXFScCACaZWMH+wMA
        AA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190603090232epcas5p1630d0584e8a1aa9495edc819605664fc
References: <20190605143219.248ca514546f69946aa2e07e@linux-foundation.org>
        <1559552526-4317-1-git-send-email-maninder1.s@samsung.com>
        <1559552526-4317-2-git-send-email-maninder1.s@samsung.com>
        <20190604154326.8868a10f896c148a0ce804d1@linux-foundation.org>
        <20190605115703.GY15290@twin.jikos.cz> <20190605123253.GZ15290@suse.cz>
        <CGME20190603090232epcas5p1630d0584e8a1aa9495edc819605664fc@epcms5p1>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Andrew / David,

=C2=A0=0D=0A>>=C2=A0>=C2=A0>=C2=A0-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0ZSTD_parameters=C2=A0params=C2=A0=3D=C2=A0ZSTD_getParams(level,=C2=
=A0src_len,=C2=A00);=0D=0A>>=C2=A0>=C2=A0>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0static=C2=A0ZSTD_parameters=C2=A0params;=0D=0A>>=C2=
=A0>=C2=A0=0D=0A>>=C2=A0>=C2=A0>=C2=A0+=0D=0A>>=C2=A0>=C2=A0>=C2=A0+=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0params=C2=A0=3D=C2=A0ZSTD_getPara=
ms(level,=C2=A0src_len,=C2=A00);=0D=0A>>=C2=A0>=C2=A0=0D=0A>>=C2=A0>=C2=A0N=
o=C2=A0thats'=C2=A0broken,=C2=A0the=C2=A0params=C2=A0can't=C2=A0be=C2=A0sta=
tic=C2=A0as=C2=A0it=C2=A0depends=C2=A0on=C2=A0level=C2=A0and=0D=0A>>=C2=A0>=
=C2=A0src_len.=C2=A0What=C2=A0happens=C2=A0if=C2=A0there=C2=A0are=C2=A0seve=
ral=C2=A0requests=C2=A0in=C2=A0parallel=C2=A0with=0D=0A>>=C2=A0>=C2=A0eg.=
=C2=A0different=C2=A0levels?=0D=0A=0D=0AThere=20is=20no=20need=20to=20make=
=20static=20for=20btrfs.=20We=20can=20keep=20it=20as=20a=20stack=20variable=
.=0D=0AThis=20patch=20set=20=20focussed=20on=20reducing=20stack=20usage=20o=
f=20zstd=20compression=20when=20triggered=0D=0Athrough=20zram.=20ZRAM=20int=
ernally=20uses=20crypto=20and=20currently=20crpto=20uses=20fixed=20level=20=
and=20also=0D=0Anot=20dependent=20upon=20source=20length.=0D=0A=0D=0Acrypto=
/zstd.c:=20=20=0D=0Astatic=20ZSTD_parameters=20zstd_params(void)=0D=0A=7B=
=0D=0A=20=20=20=20=20=20=20=20return=20ZSTD_getParams(ZSTD_DEF_LEVEL,=200,=
=200);=0D=0A=7D=0D=0A=0D=0A=0D=0AActually=20high=20stack=20usage=20problem=
=20with=20zstd=20compression=20patch=20gets=20exploited=20more=20incase=20o=
f=20=0D=0Ashrink=20path=20which=20gets=20triggered=20randomly=20from=20any=
=20call=20flow=20in=20case=20of=20low=20memory=20and=20adds=20overhead=0D=
=0Aof=20more=20than=202000=20byte=20of=20stack=20and=20results=20in=20stack=
=20overflow.=0D=0A=0D=0AStack=20usage=20of=20alloc_page=20in=20case=20of=20=
low=20memory=0D=0A=0D=0A=20=20=2072=20=20=20HUF_compressWeights_wksp+0x140/=
0x200=20=20=0D=0A=20=20=2064=20=20=20HUF_writeCTable_wksp+0xdc/0x1c8=20=20=
=20=20=20=20=0D=0A=20=20=2088=20=20=20HUF_compress4X_repeat+0x214/0x450=20=
=20=20=20=20=0D=0A=20=20208=20=20=20ZSTD_compressBlock_internal+0x224/0x137=
c=0D=0A=20=20136=20=20=20ZSTD_compressContinue_internal+0x210/0x3b0=0D=0A=
=20=20192=20=20=20ZSTD_compressCCtx+0x6c/0x144=0D=0A=20=20144=20=20=20zstd_=
compress+0x40/0x58=0D=0A=20=20=2032=20=20=20crypto_compress+0x2c/0x34=0D=0A=
=20=20=2032=20=20=20zcomp_compress+0x3c/0x44=0D=0A=20=20=2080=20=20=20zram_=
bvec_rw+0x2f8/0xa7c=0D=0A=20=20=2064=20=20=20zram_rw_page+0x104/0x170=0D=0A=
=20=20=2048=20=20=20bdev_write_page+0x80/0xb4=0D=0A=20=20112=20=20=20__swap=
_writepage+0x160/0x29c=0D=0A=20=20=2024=20=20=20swap_writepage+0x3c/0x58=0D=
=0A=20=20160=20=20=20shrink_page_list+0x788/0xae0=0D=0A=20=20128=20=20=20sh=
rink_inactive_list+0x210/0x4a8=0D=0A=20=20184=20=20=20shrink_zone+0x53c/0x7=
c0=0D=0A=20=20160=20=20=20try_to_free_pages+0x2fc/0x7cc=0D=0A=20=20=2080=20=
=20=20__alloc_pages_nodemask+0x534/0x91c=0D=0A=0D=0AThanks=20&=20Regards,=
=0D=0AVaneet=20Narang=C2=A0=0D=0A=C2=A0
