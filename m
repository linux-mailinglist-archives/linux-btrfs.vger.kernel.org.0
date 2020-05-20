Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1C351DAE0F
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 May 2020 10:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgETIzf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 May 2020 04:55:35 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:12353 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgETIzf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 May 2020 04:55:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1589964936; x=1621500936;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ABTF4j2Z9zFnLvBU2cnBFjnt+bzqcSAo1Qw9nkzHz2s=;
  b=BXg8+MnacubqtcYACyj7otoNWx0xjqcaaKjJ4dhX3Ni8XhMuGh20uLK/
   Tt1p9CwOCHHXGP6XPhrZZ2SQkDEULeVnhbtv1Vp625+yh7wo4/es5Bc3h
   33V0xQw8P8vtBhKe1JJ1+JcgQYh+mNHQHxK/VmAuAxzrjCX3aQSR9tzGL
   QMx5xyi6fJV/6ncnGED7bG3mq+prffPXN9dsFS5FDqO5+mtpKQ5ws9Vyc
   MEtJCr7WSNP4Jz5BT/ZwkCN8ClJscJiQx1R8VOsUnS5Hug27wacpQsNWV
   BDqNO/jA8mUhqDgL4f8uazbQb8zFZgwhrQIX9kG5bn8AzY7Vcy/j0pWIS
   g==;
IronPort-SDR: 6muxdGihfZZhJFS8iGdAhT9FSTnmPFRJeyhE5WbrdenJFlnB0oDkQ8jOd+8q2Ong06Wb4VLwE1
 dR1UyLr2OMPZhMpknUc/Q0kj3gUwYsGbnKu8NL+CuaqCdTME8OqAghcN/efetPHqYnqO1OV+FX
 H8hNjWgHG1mPJ1GXPOj8Xe210nr8RTCZzWv2B6upurBUkJrVD45kHNfez6B0QK5uvEO9C3CnFp
 5HPUAzXNjYFyGYU5s4FFZNIlbR6IlnEGKSnQHr8cE2KoVH7PtSxb82BcAmhTrryk2nf6LcmPnu
 ais=
X-IronPort-AV: E=Sophos;i="5.73,413,1583164800"; 
   d="scan'208";a="142447812"
Received: from mail-bn8nam12lp2171.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.171])
  by ob1.hgst.iphmx.com with ESMTP; 20 May 2020 16:55:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P9XDINPNlqXoz3CtQXWaPdH0wJ7/KoZKHU1rOTvtkZmde4BfqBlpwHfV0jw9knrjB822qkHqQ8SWIzLouniFgCmQCnk0OhlQuglzFsF2KUoXjz1hZNdxfUeqesUPdFdXjTMDzOO3XWne54KjG6M/0qeYVU1ByuFW/iod3q9auy7eNo31UBh3aNa1CjERjLauFU36ETbWADqmw+70m33B9c8foo9zeqqxy5RsmTX/5yiD+STfX2qiSi0IM0J3PYcHrTKaeEYGlSZGbObBuASsSNXnKXbiKe1PTnN7zhQcgSihmzWyvvn5BblCO+i1xOc4XtFfgxTcxdzrt/YtXmzKvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYDVqTDbsqd8TkIhdviG8/6NtQ6orywTGjRH4qlkSTQ=;
 b=eHXqLcip6YtPCiT/M/fo3bHVekiUMLxGXWAyob4NT9c9N6NEXqR/Cb/eB5TqPxPFv59NgDg2+XwWRzY1qC+C/FQXy3WwdMdu21x/pqYlAxA+nYkLjrjU/3YbD2/tagNtG8phMoXG57Lk3Ni8QGBNuiUNzHjulTJFBpmTeyrgVk2D7Uwdroyi+L7RLRQO+7lmZvmHOvWHYc+jzJUkCjytLoCPDsWnaSXYkBRkJpd/iJufNtE2vpLi32AOi4JZXXKqqqXQ7Fi991LuK5KSyVJ19Ws3+Ce78VIR6ROGDFxJ0Hb5PA7tEikK5s2uGXA+KPszeUEa9eq1JbXYuJ2Et0KUCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYDVqTDbsqd8TkIhdviG8/6NtQ6orywTGjRH4qlkSTQ=;
 b=cCezDVHjYQNsjlte6+KnmJWuL8ub6rp1NyIVxs7vWTOIThwMGRcHeu3wGxwfp4OjLPIxjdhch68VPqaXWKF3RMyIUAMMZmciIaiSVQ56cAbgVkIRslbQOmv4Zugz73lzv5Skg/3jdBxnr4KVtTgs9Tv5R4kDWmrg+FGdTlpZ0lQ=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3648.namprd04.prod.outlook.com
 (2603:10b6:803:46::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Wed, 20 May
 2020 08:55:33 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.3000.034; Wed, 20 May 2020
 08:55:33 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v7 3/5] btrfs: create read policy sysfs attribute, pid
Thread-Topic: [PATCH v7 3/5] btrfs: create read policy sysfs attribute, pid
Thread-Index: AQHWDAm9RRt60gKr002jl39/MkmF7g==
Date:   Wed, 20 May 2020 08:55:32 +0000
Message-ID: <SN4PR0401MB3598C116823F896CE4777A9F9BB60@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <1586173871-5559-1-git-send-email-anand.jain@oracle.com>
 <1586173871-5559-4-git-send-email-anand.jain@oracle.com>
 <SN4PR0401MB3598EF0DF22C63F087969E8D9BB90@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <3369903c-77d7-7cc1-aa14-85183793e74b@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 14a41e40-9c58-4063-4cc8-08d7fc9b8e30
x-ms-traffictypediagnostic: SN4PR0401MB3648:
x-microsoft-antispam-prvs: <SN4PR0401MB364838F8F9F623647DD129809BB60@SN4PR0401MB3648.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 04097B7F7F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QdetuZJYy0IruKfwL81CsJ6K91Yxelc6QvEcuesR+xD9gqBEG/WIFnTpvzJ9xKeS0BsPgd7s4ATQhBUKwJYSAS74NgVHpHGhEo9C8SlpOQftCw04buvnoSqPT4x0UlhZCKPL3gPjpfDCR7NYTqG7gnDSFB/yjzV9+dM9VMIAdg5KtDKVyFRKsczbFA8KgtJnp/0Y9GxgzlGZ4jwVzZEW0mRU9+cJdi8hEJdJAbj6ItND2AxF1jc/+3dLuYM4W2iGUFGxQNF4rD6mBMuelzui/XxL+VwP1JTyDqqNm4kuz6gSo/kper0MY0jbQJTDN/XNtTQgPLz34XCjDH553C2CHK3479e/uz06gZln0GHW3ZSbNsC6gGPZc0u5wjUtoSgkoxfWxW3W4ieYjrKsL/o3xQiqueIIoLaxQE7BNmscoUVoOFE+oNyEKA3vg1mA+aON
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(136003)(396003)(346002)(376002)(39860400002)(55016002)(64756008)(66446008)(316002)(91956017)(53546011)(110136005)(26005)(6506007)(71200400001)(76116006)(2906002)(9686003)(86362001)(186003)(8936002)(66556008)(5660300002)(66946007)(478600001)(66476007)(33656002)(8676002)(52536014)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: gKX57e5+wKfwwZ+7yIc78pWLhAdPmSi6vGvKO/uOEnXgR7S3w1dgL9c4vjXP/qUiA+5WBhoLZ9MEubAtbOaEg3WwBT/0ElhYCuseAV1OwHZ3nkryE40o5lbQ7nePFXnaPkJEcjhY8En0JTQaNUoGxAasYn2puN1nmKKbrbO2iq+C8eW3YJ2+N2ahDsYBXN3RerU9Su+lIiMmvM7wu8aOdluYstQ8YBT6Hh3iZLCDNuf63p6sUg+fMzb6n5OF5sVPRCn2mCQlmvhQ5f19z5E/3vCwaHzg19LVHQhKFb9JBeo0MFN+19BZWn0tv5hw/2CHEvuDEXqziw/Fg39VsC8ZXqHz/KX77NltCaNRa4qJCmpNjIG+yiUVIuZkPFfp5bbPfBd0uOGfrKugUr5yk85OCbJuHZ4wxPAxhQKDUGMbYsBa5youSMEY0uf6Ue6XeZRbmGUftcTuuoF+fuI/Yl4V+GOpeH9qH9ycgk98LdqtYVT/fz8J6Lfu2txMRxrt7AWf
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14a41e40-9c58-4063-4cc8-08d7fc9b8e30
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2020 08:55:32.9906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gUxGf72/Id24xNVByzWgsSY0c3sT5IVB33JrtiA2QCdgg9YngkKEGnBQgNSTnJapVtDifanFTCkSG1BRIvQTo77MLk/NyLPpIBzo1+0SgmE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3648
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 20/05/2020 10:54, Anand Jain wrote:=0A=
> On 19/5/20 6:07 pm, Johannes Thumshirn wrote:=0A=
>> On 06/04/2020 13:51, Anand Jain wrote:=0A=
>>> +static ssize_t btrfs_read_policy_store(struct kobject *kobj,=0A=
>>> +				       struct kobj_attribute *a,=0A=
>>> +				       const char *buf, size_t len)=0A=
>>> +{=0A=
>>> +	int i;=0A=
>>> +	struct btrfs_fs_devices *fs_devices =3D to_fs_devs(kobj);=0A=
>>> +=0A=
>>> +	for (i =3D 0; i < BTRFS_NR_READ_POLICY; i++) {=0A=
>>> +		if (btrfs_strmatch(buf, btrfs_read_policy_name[i]) =3D=3D 0) {=0A=
>>> +			if (i !=3D fs_devices->read_policy) {=0A=
>>> +				fs_devices->read_policy =3D i;=0A=
>>> +				btrfs_info(fs_devices->fs_info,=0A=
>>> +					   "read policy set to '%s'",=0A=
>>> +					   btrfs_read_policy_name[i]);=0A=
>>> +			}=0A=
>>> +			return len;=0A=
>>> +		}=0A=
>>> +	}=0A=
>>=0A=
>> Naive question, what's the advantage over sysfs_match_string()?=0A=
> =0A=
> We strip both leading and trailing whitespaces, its not=0A=
> possible to do the same with sysfs_match_string().=0A=
> =0A=
> For example:=0A=
> echo =3D=3D=3D=3D These should pass =3D=3D=3D=3D=3D=3D=0A=
> run_nocheck "echo ' pid' > $sysfs_path/read_policy"=0A=
> run_nocheck "echo ' pid ' > $sysfs_path/read_policy"=0A=
> run_nocheck "echo -n ' pid ' > $sysfs_path/read_policy"=0A=
> run_nocheck "echo -n ' pid' > $sysfs_path/read_policy"=0A=
> run_nocheck "echo 'pid ' > $sysfs_path/read_policy"=0A=
> run_nocheck "echo -n 'pid ' > $sysfs_path/read_policy"=0A=
> run_nocheck "echo -n pid > $sysfs_path/read_policy"=0A=
> run_nocheck "echo pid > $sysfs_path/read_policy"=0A=
=0A=
Ah ok=0A=
