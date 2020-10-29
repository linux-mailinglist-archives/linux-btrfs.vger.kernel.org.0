Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94D9829EEA3
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 15:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgJ2Oo0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 10:44:26 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:65333 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727803AbgJ2Oo0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 10:44:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1603982665; x=1635518665;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=kEod6mWtWH1oESe5psn+mxIOOIyFHxVLK2owRFD+hqg=;
  b=UPSqwg7/eH5mh43gptzJWu5I9HGiXgvhwtbPLG9eqoBmNIeX6Y461bdw
   4/x6N1xDNF+IhZiyQgtyfj96zH8TmGroHhfSga8fagXlZlHr+Etu9dl6a
   IUVhPKIEWPK4ZhKmgZ8bu6+jknsfArwQjCIkbvlO6LUwipfbrrFg6WeYD
   X8GVtctnD/TAKHwMWNiz+PLQM368wWddKyROagNDH9PNExmkbHwqtSybj
   hLQDTZ0fTnyWkweU1/rh260ZmBc5wgihBY9Ue8UA6DaMnt6XcNL8DRI8Y
   ytzkD3ixWxzb3fTaeZPN4JF/sxHC8Ww4Bz1xDQhdxiupS3kjpwE4OxgEj
   w==;
IronPort-SDR: 13lxh6jCE1Y42F2/csaycpuAk9COfjR06xwI2V0EoNOfkd4yCOUyuOVffJXZxTcNEsrP7A3jNq
 aeZycRgCCpkvrHdQV+ZTI9ttshAQKW/ykJZ5JHDbOrVwlEFfOlvU9yNM9B8Yxd1HwUY30aJk5F
 dKsb+hAcTF4ffDVOboMSKlIRQTDnwxJRE7uLATptyAPFIXvGgmeUUgqXw47jH2J4a5K/T/dZHE
 VJ/M37FSjq0XcPbOHVaXtpHDaduBvLG+3B/L6jklHzcsxVJsPX4WoBBzPtYSru/trXOemznDZs
 4kk=
X-IronPort-AV: E=Sophos;i="5.77,430,1596470400"; 
   d="scan'208";a="151319269"
Received: from mail-dm6nam11lp2175.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.175])
  by ob1.hgst.iphmx.com with ESMTP; 29 Oct 2020 22:44:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dwzeSmZ043lDQOP0Q334wSwjwQaqylcsWkRHcEta8SLzvf+JkJy2MndSCdMUwkRD4zaeU/GmqkVICGJvxB9EXpzIbWS0Rgsf/M1FFHjnMA7YYyWi5j4NfGfguatXw/O0b2sjMCH6yO+rnkSX2hKyWFlLkwEIA/F139LVLYIVW8Cz2HqF/rLxg0Kr3cDvh7bsJ8MX2werfDtJ4pDdT4s2+ZoHzmR80+IkB1IwSo8ekhDZi1dl/yOwo1EhEHuPYGNmyN6Kt5IfzOMyGWh9D9rwCnF/Vgn5J9+zABlCa6IYKtZgUZr9BEUW+GUsLX96JMQAylSTdrjad6rlGE0f1E+hVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kEod6mWtWH1oESe5psn+mxIOOIyFHxVLK2owRFD+hqg=;
 b=Q+QN2ZVCZGzErOrD05SCft71+wwIzF8gDsgh0OqHG+gPuDguIUsA3o/yOYd8R7z9OEqE8fkFDOZ1g5wSl0kk7ZtIS7RgXQwv2ouyS8Z46oj1MwOsdBqGf9DIQ9aI0x1ROl/fiH/lzyRa+cG85vu8ecKDBTMWNYrcBYhA7BbgMXt+WSEyAIRcxAGxC8DkWT3GPgqLoo+mE0144vUHMGt5IaspAXyBBALGp+1mO9npw1vu1xNoPMM4cXFcwVRkfL9mFLDu09qqfmbirQs02pJPVD9Xw+RSt2L+rM/QjsIpWSrUSxJSV1saE2LyP+oPeKtsuW5OrZuuyX4cqNqNUuAEEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kEod6mWtWH1oESe5psn+mxIOOIyFHxVLK2owRFD+hqg=;
 b=J/EsU6AUMpGi7rzeWCS0L5nOKZdNO0N7WzXOUlWki4NxTR0ZS9kx094ARhw4knK8LBeOY5RYgWEOQr429MgcQSvz+kNgEEKJHwRrn2c/pOlgU4J55ymTiTT28alttBX4+wuxdQ7cNeCNHJ1E7Qq2R22pEt+NU6z0g7xW0j5BZig=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3677.namprd04.prod.outlook.com
 (2603:10b6:803:45::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19; Thu, 29 Oct
 2020 14:44:24 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3477.028; Thu, 29 Oct 2020
 14:44:24 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 09/10] btrfs: check integrity: remove local copy of
 csum_size
Thread-Topic: [PATCH 09/10] btrfs: check integrity: remove local copy of
 csum_size
Thread-Index: AQHWrf/w2kIuSftVNU69CIszgpJ3Wg==
Date:   Thu, 29 Oct 2020 14:44:24 +0000
Message-ID: <SN4PR0401MB3598DBBFEE86307BB25DF6B09B140@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1603981452.git.dsterba@suse.com>
 <8005d5d4ec27e0a966e2c2dc9af73713b78ea8ca.1603981453.git.dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d064d9e2-59d2-4eac-8336-08d87c192132
x-ms-traffictypediagnostic: SN4PR0401MB3677:
x-microsoft-antispam-prvs: <SN4PR0401MB3677642620DFB6209ABFBCD59B140@SN4PR0401MB3677.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k+cXj+yNg57bTG4MUWI44haQMFlEecQVKqOROXvbYBrsYF1kEAzGeKYp9uuiFerMNNSLqsH3nsfFT1bRdYU1HAk1zeR0X4xiH7o4FzWlDZknEjPSvQa6Puk8PCzbfRaYxufopLb9pUjHc6R5iwAW69hpI+sKHme33e7P46F+yPhZcDXS1sjPy5+dHugtgPyhDQBSae8sAB9eQEEcsWXoKC98hbSbKWVVxi9Dmp9eEH7w04jEXrmpfGy3oRN+vE9XWebGiirySRTCqWvstpiL7++iZX0dpxorCBb9umJXSmef+/AaPbinjlv9xcz0Y0s2P46CF2kw++Tlj3B2jIInjg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(366004)(39860400002)(346002)(136003)(26005)(8676002)(33656002)(66556008)(52536014)(55016002)(53546011)(186003)(6506007)(9686003)(558084003)(8936002)(76116006)(478600001)(316002)(66446008)(91956017)(64756008)(110136005)(7696005)(66946007)(71200400001)(66476007)(86362001)(2906002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Vt0fSCeyjPeOcWYEBH57iP6D9hTG7cI7+2qPmbFIYobYiL1uqg7eXE174+gW1GojlhABeM/nQxDHT8TIRPACTlxKF3N1Eg3G8ImvDwdbVaXWqPjzak0HzXDk+Rbea1HoPUM7K1F90tdBXicJn0HufhIF7qFtO9+ZJDCWoygvFNYYMrZSG2KahYqjw9HyLO8YTBU+jxOvxyJjp0TVV0tt/zHXILjr2CFs/r7jqw1Q0xx4CcxIIo7hxDwmAhOkMpIJZPg2tcxkAAHcx5rR/O34gEtAnJ7fwf0WmQDK4DecoupBDIZlrsvHrcxYCcAsfNZDfBK0/hLEXSkjLmJVzOK1fL+q/IPXCKXzyE6pzTk+/ZRVnmbIN+64CN4yUmz9IKgg/2AOCZ/KKGmz2UKopFZVspDisGWTYWQXSr6K4ChxYzh8HnOcoawfg4DRu98XMLiqP3OxSC625ot3MpzCTLkHu5JXbspJPDxv1IkRNqNc0eG+VYQDIDBswEOiIPjSCtAtBZgSuCD6NoIBftrs1fTi+47WiUZL2XAZNL2L7Ljh/3ub6SrBR21FfafzAy34Zqmf7vSJ0u2apVliSl+ZKdVWYby6UtS4osdkQXlnMUhBi0DfyzyqYi2hxsSkmPCbY4RcehzK3sT7jccAi0MvD/mJ+g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d064d9e2-59d2-4eac-8336-08d87c192132
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2020 14:44:24.5160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wbyaDdM7YK2zxeQRA9FMd0d3nwLRI1Iij7dnh/iBoQfqyOfGLAf3mhtN/M2T0SkdogKYprA7mRCTtSOA5t0qTFJtJPS5cN1GrK1l/8Btb5w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3677
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 29/10/2020 15:29, David Sterba wrote:=0A=
> The state structure unnecessarily stores copy of the checksum size, that=
=0A=
> can be now easily obtained from fs_info.=0A=
=0A=
Any reason this is not folded into the previous one?=0A=
