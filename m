Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07F9420DD41
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jun 2020 23:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgF2Sjb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Jun 2020 14:39:31 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:42831 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbgF2Sj3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Jun 2020 14:39:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593455969; x=1624991969;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=H3pOH2c03SNt27P1oiwuYcZ0sZ9YqKujVs4H8+hPjUE=;
  b=caGttf4qCpmCnU9rq7yTvYhlDpPplUEpK2Nn+mbkYfH6ghGGU6nAK8yr
   KDtrMS8yBCs31Los5t/Y1ChRpPZb69Cdx/adKMKzT55oZMqYaQdEO1WsN
   AIBehZwfdqTu7unGbHEgvGBvqjqHg/lwefhMKu/iGfaVG7mynGDOMbu/x
   D3I244HCpMc3SVKIXupc99tMY2FQ3XWsfOx0EXsFybjkkp9sxKyCVR/WL
   0DxJKvTcoExTxW0dqYOrjLMwjIN9dk7qiTEXL6wfgpjZf68Hgmdx6kA/V
   q81Fr1ODJCwYS8rw5aI64CVFlY6lBW6JwD1FiUbCvPgfB5B96qkr68BD1
   g==;
IronPort-SDR: w+KpzMIzp74LUE/SVoYcBaoViQAaUpEMNi1EnaE0I5FGv9VOSTQV9HBTANlsbqdOJ30IhpUUog
 xRR3ZRv6N7PsxP686RVUudoH0CAtd/qSjxLgSjgum2us8dz/aSOGz6FaSzg/Ilk1aHfa5HXywI
 /NTg0YKlt5KI6DoVRUorHQzsGeohUwSb4EMYw3ndgSBUYtGhjS23jy1XYkwGW75qvU0/UnpxwI
 C0kfqDUHmGH0TXITKatIqUD9W29HfCn2dCEhSxDzg+aMi4a8IjhaU2rQgYq6rgFfg8ex2DhYS9
 cIY=
X-IronPort-AV: E=Sophos;i="5.75,294,1589212800"; 
   d="scan'208";a="142519035"
Received: from mail-mw2nam12lp2043.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.43])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2020 15:21:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cw9mGiZ6zfnuk47zU6tJ5s852gbPuvsG94Kj+o+qxBeXTprjPQC1y/I+56iCP3WqIAfAGYPVWcP2DWMkt17CopTgyJgjm6tBU2oqVScp/GSH+jm0Y5lk1KMIr0+fUCxtGJCBGZ4C3A0y9YWYh9rVT9t0AZSxKmiDzyDkSd2pKgJ7N3zynfLcB8c8YfcU4WftDjdIxBqKbSAUYVEN+9wPQx1KZjgWVNe9fm9uwCEMqAqfP2kYmsRqw9RffPVu6rBqpCQphKSH2PzzRhvFYhASjfgybNIuDEk73mkusGS21NjDZgoomr9nKiSnky2wgJLLHo8RPKT0KSiMUm2vYyjw5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cvZ9TC+A9EA2bsizsNU9N3SURkZ+ITGrsQcJYepXNdU=;
 b=b/oP9QakvFtj6Gk6ZGKAFPFXTjbBnBk4aDRQYN9YJn9pma9SpDEvA5pGrmU282XQQfDcv9A1vPhsg+4kd1Vyf2Y27uT62R+Xd40l2NCHHjXf+SnYBOls1srbkHIeUgnm1Tf1mEr65++RdxImjRgCKv0MQRF63Y0bnGwu1miq13yh+yln8RyrfKnKwZ8rGI37NWmAEmhOAOFUme8MvPfw73X4sqJOy6pSq0/wadebmvN2ZfHJgptsXrnmTA7vVb2486Y/PVN/A/klBEpFaNxlCztp15Qp3X/9HWX0M5MJMtrheJb3MKw5wBLBf84mCsm3Nc1Cgk1F6sIEKbR5vOOxDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cvZ9TC+A9EA2bsizsNU9N3SURkZ+ITGrsQcJYepXNdU=;
 b=F7zvm1wADu6vJyD0+wBgBy02hI4w+6pnIoq2NRALkENYKRwrFcDFtF6bFd+ErdMTeOGgI3ELnkaxV0MMbLSy7Z4kKUFby/Qxn6H6Hv7fPuQw/Yhu6hszywSbQcjnFVuDX4gmUwOFkvxqZtvhX3F6tzCJVcNG8ozBJW6hHn7KXuU=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3520.namprd04.prod.outlook.com
 (2603:10b6:803:4e::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.25; Mon, 29 Jun
 2020 07:21:37 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3131.026; Mon, 29 Jun 2020
 07:21:36 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH v6 3/3] btrfs: refactor btrfs_check_can_nocow() into two
 variants
Thread-Topic: [PATCH v6 3/3] btrfs: refactor btrfs_check_can_nocow() into two
 variants
Thread-Index: AQHWTQumtHw0YuLQiEi8HGKNSWneVw==
Date:   Mon, 29 Jun 2020 07:21:36 +0000
Message-ID: <SN4PR0401MB3598DC054F342A7E412059349B6E0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200628051839.63142-1-wqu@suse.com>
 <20200628051839.63142-4-wqu@suse.com>
 <SN4PR0401MB359839A2E5EA48ED5D0B2E2B9B6E0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <239aeeb4-df67-6a9b-d71e-8855404ad004@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1515:bd01:5d2:80d1:159b:260e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c16500e8-8bc1-45a8-e772-08d81bfd0f40
x-ms-traffictypediagnostic: SN4PR0401MB3520:
x-microsoft-antispam-prvs: <SN4PR0401MB3520634B1C083E9E8B8A42A09B6E0@SN4PR0401MB3520.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-forefront-prvs: 044968D9E1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e/7FNUuej1NAo4lJMios1hKEKa/8D6cE+TIK6lIXn3QGcIvE9GSLMpUlpRzHd9WqYmTS4FmEpWPtf5vnS3yqUAhOxulysK2nWZN7wXlM4k4w43/8d0qaqYGgkYIZNeQFXbqfNbxVyvnUSe0pKH14RNbXc7Gg4jAwcnL6UpjQs3gFDbyYAR6VDnbYLFGWhKrbRTDISiBGWrYB+cp6DoMIwkS//JKyJil1WG8NoXFSNIcQAF+DHds0EUA4gjIXqT17OEFsZrB0t4Nwt3BGhRwgCGC4+jqtis4EkXvRX/Q9Vf7wwxjKdEP+2n7IoDnWIFJpbrN9Is1sGA8sQJP9z3xFBA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(136003)(396003)(376002)(346002)(91956017)(33656002)(76116006)(83380400001)(53546011)(4744005)(5660300002)(110136005)(6506007)(7696005)(316002)(186003)(4326008)(478600001)(2906002)(8936002)(9686003)(8676002)(86362001)(64756008)(66446008)(52536014)(66946007)(66556008)(71200400001)(66476007)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: u1cBfWd+wWpGyhm3V59bvUst+q6ZHivid7lIb+BHWcUQp9Cb5pwZ6symTdFNHfVg9DjfKhHrqz0PVLgCUC6dO4pTMwdVUCmCMfpPGSzlBqUAiIn2eiLP/I/kmZnIIFVxfLPCDS4DOGT5QeKKdxwvLKKM2slriAWp4BZuXEnk3HIPIKhrUvHXvOvAJAQ+/Ib14KE5eGQe0OUxNK9GM9luY3gaEnVojG3lTw6vRLNIOphs6DYrioLsULwxyTMLduJevbCmPvIel2dcOiUPHrnD1z6YfuyItYzejt/vb4U5woDkNwhuDd+Unp4dJa0nkIuJD6hCLiL1HFX777jexIa1c3lUM2r957ILGkXRcn7AqNf0HxgQqoe9/ezxpZ6TsJG0DAvICqpU7JUDDSEN3bPehW/8cEu6uInbBE9wxt+3aSmd2tKaZuq4uNj/1QiZw5KmbOeZgZF0VVa13wL4OafiCQ1mPiUFTmc07yMsTrlvUAUWa4ACMDKPZmVqK2QdrvnAzgEtHjgoYxZPSOv83awFum0FsmROUx54hyAInaMEW80=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c16500e8-8bc1-45a8-e772-08d81bfd0f40
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2020 07:21:36.8213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ToxrxLwlPr0BHAyR/2+ehWh/HZ+LBS8c96H8rJtmrhlBD+3GC8bZysr6tz4Yh049yQ9WtFvSAZ/ZbykNwpxqa9NPiwDP0VmPUq2RK7VPIn8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3520
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 29/06/2020 09:21, Qu Wenruo wrote:=0A=
> =0A=
> =0A=
> On 2020/6/29 =1B$B2<8a=1B(B3:13, Johannes Thumshirn wrote:=0A=
>> On 28/06/2020 07:19, Qu Wenruo wrote:=0A=
>>> -		btrfs_drew_write_unlock(&BTRFS_I(inode)->root->snapshot_lock);=0A=
>>> +		btrfs_check_nocow_unlock(BTRF_I(inode));=0A=
>>=0A=
>> Huhz?=0A=
>>=0A=
> That's why there is a v7 update...=0A=
> =0A=
> =0A=
=0A=
Ah see it now=0A=
