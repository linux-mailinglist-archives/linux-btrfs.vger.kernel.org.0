Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCBA268965
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Sep 2020 12:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgINKjr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Sep 2020 06:39:47 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:17928 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbgINKjY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Sep 2020 06:39:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1600079964; x=1631615964;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=x1sRANQZfFqI5BLXnL6G9StvX0ChVYTlr1r+VEAf4EY=;
  b=JVBTqOCkMlEHIoha3tla5IFGareyHsuCDyVSNfUAsrcJxlIGti7/yWaf
   zPOEwi9DHgdPGVSZiP/xYAt/MWYbpIpnpZjRO2bepbqil27UEtE77c3xE
   Ph8HNR4n0rC5ifF8IJTPNyJJarx5Oxmjux2DxSPVLI0jnPypPHlbBTHr9
   s+ZhSrtxP3g4irjwdDzv3TloYGjE0BYwNC1sJz8B7cpVvjM3rISZy/1Tr
   u9NXfQkz9Ycq0PY94x0qMaZIg1X/EK1Y8VlA/r8FWof6Aal3VsbFPBVZK
   hERrT3efb1P/xqnn+AsfYKistQJ8AynHLmLD9MX7pwFQctVuAiXSljU9Y
   w==;
IronPort-SDR: c5vj5Or+FH3Huip1Yo7vz+s7sgYfHdyXTCbUKnKyjfARYrILX+N84JIkyaY2hGOchBH5kMLxTw
 evoBR8HKMk03VR7wYiDFMJZpcIVZMx5amnEn9mgpkWsZ0Xe/lKy0lVshrrinJEQjZJeHwIvfFO
 KwQ26NSQ0L/RWGnEpQFTs8IdlxRBXap30cKiiVM5fX4/5y5psFn54GUulFOLjCgFbTWQOv6/xt
 vJKZjh/dAEBzJcJH44umHSdE7YcVHcYKYwzlvnkyhrDgqRaib+7n2jhQHoK/mlviuDyPNM7+d8
 PrQ=
X-IronPort-AV: E=Sophos;i="5.76,425,1592841600"; 
   d="scan'208";a="151661514"
Received: from mail-dm6nam11lp2172.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.172])
  by ob1.hgst.iphmx.com with ESMTP; 14 Sep 2020 18:39:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kQYOwBgT19MHNdOgqpqepBwE3m3/BUjgWv3uLA3eiipsdoHqBbfBqSKbS+JKn0JElcM3KsUqEKyH9sf30lm8XmX5nUdZarDPrU9Vv0XLEKGeeZ7ToawsxCn3z9GM1Ggnnlt/CG0thfc/6YfISVfxE6d6T7ZkjLozLZ0a9bne6bjNzS4jWh8DQ/EtSgXgzGYcHEokPHgtg5PkvWyX0PHSkROJxML7zvr2RwFNSMAkTSQMo+ybOr0WwipgG5dVU6cUBQP1Hh/bzw67rsdPEYwW8vaesOWodZ9lGhUf5GubqAaOV/VvmP1nGeCLG9uNP91YpS00SISmYRMJrGkDWz5Yzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1sRANQZfFqI5BLXnL6G9StvX0ChVYTlr1r+VEAf4EY=;
 b=VpAvBqMLBlgnID3Ck085XS0cYjIQJonQX4xyITSfidRKMEVu3lDfvkJn7fo+ehaMCWeG3by7+QzENYdgX0aLxlgK6LQWfQFb0+vGvAjNXkllq6HXVE4/Ays6cnkzquj7MG9crX6i1fu7Q2VdhVDRqulCPQBYSULzUcuuGLqFKShYle5VEjF17cJXer4b/S0Bky/lrGkDhFV5UAPbe3dpIKcQ2cIf+I4VwraBbpcwmiPSOdtCjltBzyRlF0A+WtWu6KhnjpFmMw7xmysC09emuAx2UNand1AMizanlEWTOS9OjvTSbtp0kv0infcFab2vz1BH+ccNFan3Euxah59siQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1sRANQZfFqI5BLXnL6G9StvX0ChVYTlr1r+VEAf4EY=;
 b=QM4EsUZUSywgVzQC841eH8geGP3nhrLayqkydhjLG9AkYD2kLJ0JjdgFslRC83h4jg7NShR6T9vyqd5jDX1J1/Du2t9weZEpvQLgH9y2qHzDqXZoPa6SwcE4zONsCHfuhY/KyWfr/hdhUzbQZeQ2nc9w6Lfc/4nkgsnw8TUZCw8=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3600.namprd04.prod.outlook.com
 (2603:10b6:803:46::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.19; Mon, 14 Sep
 2020 10:39:15 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 10:39:15 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 0/9] Cleanup metadata page reading path
Thread-Topic: [PATCH v2 0/9] Cleanup metadata page reading path
Thread-Index: AQHWinqlp80Hm55VfUykQRnZ4YeYmQ==
Date:   Mon, 14 Sep 2020 10:39:15 +0000
Message-ID: <SN4PR0401MB3598C03BCB90A41366EE4E4E9B230@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200914093711.13523-1-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:142d:5701:89b7:64ae:7a10:bbdf]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 999632f4-67e6-4ed2-34e6-08d8589a6d1a
x-ms-traffictypediagnostic: SN4PR0401MB3600:
x-microsoft-antispam-prvs: <SN4PR0401MB360040F779B13E39BFEF84379B230@SN4PR0401MB3600.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jzjYVp5ujUmykZqatx3YNw4+iaYC3pjcUIhHT9FOpT3DoJYZTNgCjHGVE6O69L0eQqBNZwp6dXCdKXZ4BZyfvefndUDn1Dzi+WrG3eOx7wPTPAGTdQTx8YGP2Gjj4nj+YM7QKuZCfoFVfigdzm/Gw45Y0X5SvinQxJTUzQlUnFEq+13fMUEsFCsWB4Vc1ul8KycBi+zhmM0/yHMUZjD57s8sxh/m5AHUa0dyPrFaGg26biIKMemNrlM5VL4E3nIq9xBMc8h5oIMG056Ns15EaTqF9b4mT2X1qD8p//TrN1MbLrTDnlzx8Eahi3Zj5u/uo2EtJKU//32VN38W56gK7aSDECpqAJVQkhZ28lBRngaRsKc4Ke1a8ybkYFJNgCQqxMnMau+W27pUZjaskF0KrQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(396003)(366004)(39860400002)(966005)(76116006)(91956017)(186003)(53546011)(6506007)(71200400001)(7696005)(508600001)(316002)(66446008)(64756008)(55016002)(83380400001)(33656002)(66946007)(4744005)(66476007)(66556008)(5660300002)(86362001)(8676002)(52536014)(110136005)(8936002)(9686003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 0J3ZZ9LGDX/8eDNZw/JYievCE80yx50ihDu2H/1PYeMGAIq6ejp6mSyYCvMj5Db/s2jM34G8vJiMmLdnczpAe9lamGnqRf1I41Z/tJjSYBOBDkB4D3zdAmbKlzChu+gczJ+Yzk8xqDoqfNx602Ihvo3aYn9V7BTB0HkqNMMGaLtIbnMfxR77P5CHSvLPjQITyNIaGcWdAA+BO3Z4qxjuYCyP1XGmfLWoTxmOug2poAk7qmqLsZVQO/fMh3o7AAIbjraeVVAn0L+GSsQPQBQmFFjmHFx688RGfacKxZ7VhoHJj/7UPXlf0mv/UIYen1p6hy4TUwI+VQXxRLVVQqH3nKlpDnMuW8P5kSm1YeK7r3p5gl0a8gl1NF0d0rhwtKXdaa42TT7o2VLBkVOcpwOe53wXS9Ku93htFEyguoFss7b0Af4y0brTmlTwlmWAuznl4XsX5Ko3BlL8TaQXHgi9VLRZolDbUXQkYP+PkvGNnlxe9bGPI2XCc37YauAiS5VrrNs3w/BANzWwb0a6HYZrhKtBJnK1LESSBU9MjGvMyQ/VY8bfW8jWZJT6BvRw2rvdEOOlp0v9AH+vt1MU1ymWEn7Ymf9Q6LjXDF2tRnmanPRRXAO5YdYWsurreLj/OR0jOdN+itXQ6505FV1EDSW9WjtkF0m/ReQW2Lk9qOMk/hU2+FuSYkMwy388meU8nxWS8KRcj7IxjRLOUXNVXXVV9A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 999632f4-67e6-4ed2-34e6-08d8589a6d1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2020 10:39:15.0497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Myn/XVX5U1p4iHDnNUOcEiMM2m2ID+S83C4oy1DB56q6n3NwhZLD+VC5rV4udUjeLhFNHI2IZqWnNos3e1UGMLZ73yMC1TBe4ISSseRAL4k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3600
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 14/09/2020 11:37, Nikolay Borisov wrote:=0A=
> Here is v2 of the metadata readout cleanups [0]. This series incorporates=
 the=0A=
> feedback I received, namely:=0A=
> =0A=
> * Added justification why removing btree_readpage is safe in Patch 1=0A=
> * Dropped Patch 2 (pg_offset remove from btrfs_get_extent) as Qu intends =
on using=0A=
> it in his subpage blocksize work.=0A=
> * Add a comment about caller's responsibility for cleanup in Patch 3=0A=
> * Added RB for patches which haven't changed since v1 and got RB by Josef=
.=0A=
> =0A=
> [0] https://lore.kernel.org/linux-btrfs/20200909094914.29721-1-nborisov@s=
use.com/T/#t=0A=
=0A=
Apart from the nit in 7/9=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
