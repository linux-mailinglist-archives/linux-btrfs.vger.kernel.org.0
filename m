Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B15AF234037
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jul 2020 09:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731674AbgGaHjJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 Jul 2020 03:39:09 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:37855 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731644AbgGaHjJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 Jul 2020 03:39:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1596181148; x=1627717148;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=L7xTyd+Ruw2QY0ArdNUMaRh7hCtla8vVb+X+wqD1Bcw=;
  b=GpC5AN6EevegOQ6GJFSaCUArmltvh+Z3ffjjyM2b7hVx08piR9dzRpGK
   FwzBJyEjw9CEUAeL5OGO2S1KMRz0c2MzC6DLkf8fAyyQ/oP0znqqjtzcZ
   PZ3XXH9FXEYz7Q/iOGF3mqGsN7l2nqg+6ZmUeACUUj7XHDXa+55GfOLRx
   8or6lk7vIM6OBqdE/l9rPaPc94NtJjCEMThGW5S86rAB5LFGyiXGKr1BN
   D+N7oQlAOLKjscN8keChJQ/SlQkt5MUF4NLB8CiT4BcQW7f1GHTyFnsCc
   PsC3rrtSsNdF5VJgGLZQVyho8BdMUBE7tj6CaKmiPAk+SFcwzWMxFiwvs
   w==;
IronPort-SDR: 1+p8JtbsShpUGS7EOMSmmQbVF0xdQ1xaTg9BLm+p4Yt9aRmTBS4FX2JBH74gSNDrynRxG78eU+
 DHqWQxhniq2JyM4+/PWKvqhwxzSht7ew5mHGZVH+riaA1AV2t7Q76QeXso11lt7GIQ61pMJBw5
 Z+W2wX6mmDBQjcWkTe7GrVjCV97VbeqQSAL/nTqRnMZhzBnUd8bcIBsS4EJFaWDCOGxMX0dVrr
 xYSHB2QISu9lRUpdAlJYhWoYoy+2gHnTe87gyn6dtpcxUScXjxR7pjRJu3RSIbYD/hgPPKIQNv
 L80=
X-IronPort-AV: E=Sophos;i="5.75,417,1589212800"; 
   d="scan'208";a="143820807"
Received: from mail-sn1nam02lp2054.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.54])
  by ob1.hgst.iphmx.com with ESMTP; 31 Jul 2020 15:39:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P0l2Nt7NAsmm9u24jmvWG70jh3OxEwtF8WUsgqNEUH/0EwZa0au5X4WuFmqRx3XdG3eydTyPWsr21oaJfSkeixjIFvcPLZQoFmQdhHjM/llzI195yU7TIR2EZyr+zxL53YLOHsnexjFmj0s0nXW8dCRTDGj8W9zoFUjy6IZlE5pjnZpT6cf/gcyil1BipjhjY9cXJ2pbldJUJ/EhV91OWGs4B1B35xRbsfJ46RFsSaA/isBcMzfUOBpNoPu3Q1XBZjYCCZbK39vU8UcBk1PXABywxPGdUMkoYkQnU60571Qnr1OQ3h8cIuTafIms8iYI8CTzclrvrT18nEBeeAZhvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7xTyd+Ruw2QY0ArdNUMaRh7hCtla8vVb+X+wqD1Bcw=;
 b=eyzCnd4qnSe6zWCubGTrSGTs3RmADAE2HfpZBqOFRsVHKbY7eTkhEu9rf8yjKCL9UuPXB9HF+TwS5CDnhuPF+xcJAnBeSPHMhv5W5jGq68gRBW30RI3PchCKYtI2UPExlgdYrDwGWOPffC+PRJAoGTIV4Y8WrLXzFIo+kZa08ZwqGX7SP6/8hro0zgLRBkI7mGnGymXH2+tAG970aCXEsuiQvCyUqEEtvJAR3EvWgALOSRP+Xc9d7ujHqxXPxltQxz6VjL4xl48i1XyzBHdD6ZcjKUozCwvy/PW9PIVwsufj/1cyhciowRRmyU9irw1pkKo39iWGq8HJw46GccXGQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7xTyd+Ruw2QY0ArdNUMaRh7hCtla8vVb+X+wqD1Bcw=;
 b=yXHUvq4xokKq2PQv1sjhP7mPsWg7PdzPTETh8X2AKafOz8MXMV8e4OE+08QGgX8bVNTq4/Wr3ZrLliNH5Y52AWhXH8nXrt1L+bvRQU8slHcSeZDDROMWqAEuqC4QQ/xtlSU5mYdy431pxDM19WfgXZqXWIZVziEaQi6+mUu2yJI=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB3966.namprd04.prod.outlook.com
 (2603:10b6:805:48::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Fri, 31 Jul
 2020 07:39:07 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3239.020; Fri, 31 Jul 2020
 07:39:07 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: handle errors from async submission
Thread-Topic: [PATCH] btrfs: handle errors from async submission
Thread-Index: AQHWZNHasSmazuXW1kKKzl8/lK/uKg==
Date:   Fri, 31 Jul 2020 07:39:06 +0000
Message-ID: <SN4PR0401MB3598FF781B4DE1120955FCDC9B4E0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200728112541.3401-1-johannes.thumshirn@wdc.com>
 <20200730164657.GJ3703@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3a7cf364-f133-4a08-619d-08d83524ce60
x-ms-traffictypediagnostic: SN6PR04MB3966:
x-microsoft-antispam-prvs: <SN6PR04MB39663150987E734062DC4B2C9B4E0@SN6PR04MB3966.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jKoWC4Ydc5AaJqszCPPk5KirAEF7CA+WbsHJ6D1R+7ypq16hWt4K4okO1CQMYPsDagqGaHRUL3JfqDyPyl5ZqLRPwSuo5ZgC/jB+kNeaC27eS2X3eh+HDPdsV+zVLAA75+TY2ZS5f2v9qsJESv7sANSLU3qbo00tYWrpRIuKZjA04LdmE2lWbLTBzlB1IS7D/8KU79Okf43l9mHwAC0k2srYNz/zs7Qer/2rcQ8pPqsPCKhIP2C4VWuna24Sew+boT4oUCcyyLixXHt5go50Iv5ibAQ3nCJpXRekdc9hcemUJXP+fsMrH32yr2zj2gLt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(136003)(346002)(396003)(39860400002)(376002)(71200400001)(9686003)(2906002)(8676002)(4326008)(86362001)(55016002)(478600001)(6506007)(26005)(8936002)(52536014)(53546011)(558084003)(5660300002)(66946007)(83380400001)(66446008)(64756008)(66556008)(66476007)(186003)(316002)(33656002)(7696005)(91956017)(76116006)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: bADxTVDvJWemOKELeVVSwtxoK4dLhcj83jBMrGTFVnIyCdEyRu1SSjY4Fy7Ibl+EnqHQcbQXiJIrAnNIZx9De8djU1J1GxFlXDx57o1w5dN58SOEjAOFBxZ8Vwb5X5OtB/KoK2Ec1uBrblbzoUECGtFnkUsI0sSV0V6iD7b9OI13OA+lOp2RDw+o7J9EAXOIaqQEYJNzbijnWPS+heUSpPhoQRZs0svdmMPkBZH7jg0Exr1dcvn2+RxmMXnp8vQLrelT4DzoISzLK12rCviPxS/pJ4ZnT+kdMHVTMoCVTIRpt/yxQuk5dhk83HGprt3oTDYC85iHBmch/2uArCcFlGDZKb+DeAzT/Sfqzrj7c+U2RWOiwQP+vSzr1Tg8jpEw7W6L0DkhQa8gWLcAfq/TU7x3s5c2wG/DDXkIJ5LcDrHWqodVpVk09WbbZmYfy6bQnbQzt2zpE+gmy1+BSc2MpuJa2+4JHAkmTQcC4gLRRBBdt13gUkPqqvUjuGoEBi0URXPXeUpBowzXpy5Ti/vTwaTl2WIp9Irt9X/CkXJkudnCagRFpNKXo6QT9tTJYeBFd8M7j3Z25eJQqnzfuiSpUURo5lbQbv2P0x74Qbn2qVZlQe96ZypXBL910MJQo2wejaH5Shh+1c79WydiEl7XsQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a7cf364-f133-4a08-619d-08d83524ce60
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2020 07:39:06.9393
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2qbXKL7cgxkBtvsiBaAy2qj74qN4Mfblq5B7OTCkhO/XtiZHB3gmG/zUMGjLnFRuhbmDhkqMMxPZ6xrKMHQu82YaUgHYp5ziSvUa45/FWQg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3966
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 30/07/2020 18:47, David Sterba wrote:=0A=
[...]=0A=
> The submit bio hooks have become a trivial indirect call to two=0A=
> functions, so we might get rid of the indirection eventually.=0A=
=0A=
Yes that was my thought as well, but then I got distracted by more urgent=
=0A=
things again.=0A=
=0A=
I'll add it to my backlog=0A=
