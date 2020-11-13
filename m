Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA5FF2B23F7
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 19:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgKMSpE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 13:45:04 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:56906 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgKMSpE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 13:45:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605293104; x=1636829104;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=w4KoVmOcBtdhdJB2Uw6KpfyDvJBzDcGYJ2Kfm8++nog=;
  b=AvIBBZjJoYDqwcZGvuO2YwkCFF8iehKp9lRNDSp21tIMUd+hqJXw/N9k
   ZjEOLVyRxOxUggZX9EscZl7V6+1BJ21t/aSR8MZuZthAhOn6wTphEuyyU
   /9u9lZUGcuTrYcc4K33mqBc/5TuJveaLIU65mhjqxCiZRf994efQJMag6
   /1l/bBPSuZ77ycwEOypCZGXnsxDUDvx+nAP2AtiK+52Z2uxMEaxAbVn7t
   hQzBsJcjpCUoRuM9wC3kbwWLRb6AxAFTByKvGwo7H5rh96EAKz0qYy1lh
   spkUK66Y1HmOgpFT6uA7J8jOxOfkdeWMhWPkbSrM56Ege4wj6VPf17K2H
   A==;
IronPort-SDR: liMAOiTWwGPHh7rfyF4dNSuKYCg73HS2F86i91fCeyQK0TZXtaZVXCAtikZ1ihh3fj8dKLXbJM
 bdFfBDUXOYNAV/Tc7T3wQ6TjWD6qsmoSLrFaUCFQIVidDN43TkisoxgB1+U813urateCLzIeji
 MYhLzruIQpXZwvicd7sYoViTcZvdXKfS73K6p7v8xkH4Gzxg2guLY1O1e05qwhC208PX6BMnEb
 l03yvIsMtPXGvUltPK7BPiCP3U/B18WBWg4N7e6BlFeteKzUPks5F6jFcCim7pnn5xG8NVqVCT
 ev8=
X-IronPort-AV: E=Sophos;i="5.77,476,1596470400"; 
   d="scan'208";a="153784432"
Received: from mail-dm6nam10lp2108.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.108])
  by ob1.hgst.iphmx.com with ESMTP; 14 Nov 2020 02:45:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eMNqrm9mgtgaD8+IsgbndZOTVSz5mLw39ZofQUxn/iVjx4JiUTfcb2vvuYBO5Mgep/K6q2wpMiFqy3g6ObzNZzuuesU4jWm67SgUric56ROzcMD7XvO4QrdcIxkwH4cVV9WBvq4Ju1NPZGaLBEs7fGWjDR0H3wnrrxVxagPtNm7QRG3IY812I4RbcqnyUnh11k0eK1mgBNs/t+j5GyPV6f9e3WOG9KEgvQwFc2iUOi1h7r3tW6fxWPdqBPTW6KY+tJWYylUEc+HChdLTU+bM4rgLsfkZXX3590OjZ/r7WJ+RlPdrwhA2Bp6BeM5p8P1v/jEWzwa3lyPGTb/12l4pTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vpLeOziRYrDH4I2Q5vGN7fX36DtwYgHC3AjcAeznD0=;
 b=fQjOnR//APdo8WRhqH2331/gHOpXZfOEz+pipjORARUxcaO4eiPiFJ+2v81pHVOk1JyQ1uxfVv0Yy1kuAzVmBgjVvMEsOYIG93AcL1rwTFBT9poBsoktLOGFnBQpnjvEfuhNr/YfYHSI1r05Bg9v5Fpi1x3ZUMzZVGALFSINpDfdt8klUgP4R8KsDHvEN4UF2jsA8A3nfK14q4RaoU2U3IvMgAwsVJTJyNv2QVmzQ6KNlvvPILOyaRwdWRmaFaIwsgJtuiHqG76EwinJhleKP955yZ8DStq3ZLsVN0CJ8kIVSit0vA4jCGT4nWq79w/i4mp37nFPoNm5tHfGqlptnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vpLeOziRYrDH4I2Q5vGN7fX36DtwYgHC3AjcAeznD0=;
 b=BmB1/C13REDTNDPntsNkJdD5L5kJPNKq1wJBlOanrDFyx4gBWZpyZ2ZgAC8Tv0A45ti1fY8p49oGutHLme+wTOUd6KlpW/xI7VYNDCKMgBa3hUI/SYavlTvAdIgQjNiuG9s2PMYYxKpFbo9nSxh13yNqiRyiMFuq7DjY3zjFZ1A=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4157.namprd04.prod.outlook.com
 (2603:10b6:805:37::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Fri, 13 Nov
 2020 18:45:00 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3541.025; Fri, 13 Nov 2020
 18:45:00 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>,
        Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Anand Jain <anand.jain@oracle.com>,
        "syzbot+582e66e5edf36a22c7b0@syzkaller.appspotmail.com" 
        <syzbot+582e66e5edf36a22c7b0@syzkaller.appspotmail.com>
Subject: Re: [PATCH] btrfs: don't access possibly stale fs_info data for
 printing duplicate device
Thread-Topic: [PATCH] btrfs: don't access possibly stale fs_info data for
 printing duplicate device
Thread-Index: AQHWuOtRAaZijNInYk+P8NzKw4BntQ==
Date:   Fri, 13 Nov 2020 18:45:00 +0000
Message-ID: <SN4PR0401MB3598E236821A92C90C2D7DA09BE60@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <2bb63b693331e27b440768b163a84935fe01edda.1605182240.git.johannes.thumshirn@wdc.com>
 <3454d885-21db-199a-76bf-0da6f9971671@suse.com>
 <SN4PR0401MB35987501AB13F33A9498D85D9BE70@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20201113165305.GE6756@twin.jikos.cz> <20201113165741.GF6756@twin.jikos.cz>
 <SN4PR0401MB3598F534EF6AFF1A2405341C9BE60@SN4PR0401MB3598.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:145b:5101:50:d2f1:5b43:2e89]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4b013934-2e8e-4f09-db47-08d8880439e9
x-ms-traffictypediagnostic: SN6PR04MB4157:
x-microsoft-antispam-prvs: <SN6PR04MB41578F96C0C05E501EA97C189BE60@SN6PR04MB4157.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1468;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DyWSJsAUkwd9L78FV2j9/fUCXuzz/zwsIOgqtFFdm6DcYTDosFjIGBJmsMQ/0IoIF5HRMcXO4WIt4ruT44SKRO9PmYKWP9csJDb5UUaxOOy8wNmAhh/dZ1GkqdSNB45zmX8gM97Ry6lucf+ktW0tncEdsyY3kwMdqv/mE/51APpLkC3S0pAb2NnUpSLDMyyru23PL7drkLs2HRy4bv1uqqHEOn72qY15mgy69tsZuQ5e17/5CyY7M1FsvKKmsFbf8UpSJBwUSaGhaHY1IMy9jWT2TWwy4b4idG4lIyxbGLK2d7+4GjdIiDwTm1C4Hpte7TkYgs4pWetiq8beNCUzTA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(9686003)(53546011)(186003)(86362001)(76116006)(478600001)(110136005)(6506007)(66946007)(55016002)(5660300002)(7696005)(66446008)(71200400001)(66556008)(316002)(91956017)(52536014)(8936002)(66476007)(64756008)(2906002)(33656002)(8676002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: t4puKEtMit1uiUfNavao8EJQPSjFTnNYtoeJCrrfuvQBl8TFUY2YTUaVV68QLviIt/WabSo4bO3OFQX5vO63zJS/JgFqiZ7LHuri4juHtapoaum4TluPM4JACOZzuLqkpPMPbTolyCQpTpdEPGBucht9GJxXQrmW9U5o2aFHRMBt0EwnhBsrqu1NpZQeGmF47qKi5AcsaDqeNaUalkHdZ1SgLGLxR29TZ2JyuTE3YXEqdYgiDYRrgVRyRZBYYR2/ntkZZpSWnDrVxad2Znxt/rUJbKCoyvngymtUAM7AOXUph1UGn3NT4/iEm5FgFDu/FuFGRXV85Q0MazQviobRFwP56TDWwk7rt1nvJqh/QSeI9PZOGLK6YZwiuezItpq25TF6UioU9/H6iN68+1XIIsJeMuesLv/lXfapOmFzh7Bu7CclotmEt7gAyRyShWvra7IkkJX3jXVRREpt2xaI2SuepXFWNrLVcc1sXd9oxzQ+1YdgEel1pRsaJ0ZMFWVLUTiymGD0vNjiMb8p8sulR9yXixTdkLs046R184E7IkrJm9tSmX051V7/gGJs1JsZRJ4x1DW1CIc/7O7SK6/2DTOLX8QiLcMC1rRLqa6uR6qmOEYn+mHwaJaqSzqzIRQwdAXW2Sg5kxqqmuafck5e8j/upavkUrucO3ndrXh9/ypedfXRDhrFzYuoOmsbYbe5G8nW0lMrHBdJfuDyplnkvw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b013934-2e8e-4f09-db47-08d8880439e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2020 18:45:00.4436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dm+U7AKgqCrG3cpIXwxQfz1b5jT8gQhLtccdRPptuWg549r7EpEiq7ku9MtdLQW+Wqwr1fBXdCi/5wNmNWF3o+oKcXALFgSnLsibg2dGmMI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4157
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 13/11/2020 19:41, Johannes Thumshirn wrote:=0A=
> On 13/11/2020 17:59, David Sterba wrote:=0A=
>>=0A=
>> --- a/fs/btrfs/super.c=0A=
>> +++ b/fs/btrfs/super.c=0A=
>> @@ -240,9 +240,14 @@ void __cold btrfs_printk(const struct btrfs_fs_info=
 *fs_info, const char *fmt, .=0A=
>>         vaf.fmt =3D fmt;=0A=
>>         vaf.va =3D &args;=0A=
>>  =0A=
>> -       if (__ratelimit(ratelimit))=0A=
>> -               printk("%sBTRFS %s (device %s): %pV\n", lvl, type,=0A=
>> -                       fs_info ? fs_info->sb->s_id : "<unknown>", &vaf)=
;=0A=
>> +       if (__ratelimit(ratelimit)) {=0A=
>> +               if (fs_info) {=0A=
>> +                       printk("%sBTRFS %s (device %s): %pV\n", lvl, typ=
e,=0A=
>> +                                       fs_info->sb->s_id, &vaf);=0A=
>> +               } else {=0A=
>> +                       printk("%sBTRFS %s: %pV\n", lvl, type, &vaf);=0A=
>> +               }=0A=
>> +       }=0A=
>>  =0A=
>>         va_end(args);=0A=
>>  }=0A=
> =0A=
> But this does not help us at all. If fs_info is not correctly initialized=
 but=0A=
> the pointer is non-NULL we get the KASAN splat syzkaller is reporting.=0A=
> =0A=
> Just try your patch with KASAN and the reproducer, it will crash within o=
ne =0A=
> minute. Been there, done that.=0A=
> =0A=
=0A=
Ah sorry now I get what you want, yes well have to call btrfs_warn() with a=
 NULL=0A=
argument if you don't want raw pr_* calls. As long as we're not passing in =
=0A=
something.=0A=
=0A=
Will update the patch on monday.=0A=
