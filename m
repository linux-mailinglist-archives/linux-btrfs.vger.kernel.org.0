Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA0F8168DAF
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Feb 2020 09:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbgBVIrj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 22 Feb 2020 03:47:39 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:7381 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgBVIrj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 22 Feb 2020 03:47:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582361259; x=1613897259;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=diUzWK2YksTGkDfSZcJzYri2vQKJS4Q8Gw56P1yicUyw3I8yy4eehAi6
   wHsF+l2knmPipEUjEYEeUbb/HOV0qNaUNRwzc3BW3cfmDQQXvMYvQZfWX
   Z2h36vzXgdLShMVU1I7OtGKZa4pgbEOE9ciQBhmexDCFZebJVeE191Im7
   NpA3Pd3ufbjVs8IXqAl788w6iSjNUN5KFXNHwpGl5l161EX0m5EhtUcWw
   bV2pwYMxy0EPyNx69O+koIpXDd/dGmT4doKtQHi4x8avnPaH/Jx5DMp7R
   EStfrroVTF1P1BSiIJwlK5afzFYjfFyPmR6n+b0LH+BKI1n1TuQ89dm5J
   Q==;
IronPort-SDR: 2s/hNCVBcBRMbvT8hlN7yyH5950x8HsbwZsMV9y30XaEVycgTa4KERSgfUA9asGlph93VfFaGk
 mJovcWCDK+wf22gGaUM7qvSEBtcz3r5gVuMnbCoCyqpO9U9FKFmlZ9E4NDzBMfipCl+6fxNHVV
 1DV4ORgPTIBqQ7xKvbsCjdSir4nCpu+J/Q4n7cuXW9lbS6jf5ieh9pL5t4cnsSFwUcTZ4OXIpa
 iXAP3hcA2E7ZXRW36/alrWtjUNeqeMpcV87Ybtm2s6Tct63Zq3aCOiSxTBp/Jl6IH2zQlH/sGS
 UUM=
X-IronPort-AV: E=Sophos;i="5.70,471,1574092800"; 
   d="scan'208";a="130968219"
Received: from mail-dm6nam11lp2171.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.171])
  by ob1.hgst.iphmx.com with ESMTP; 22 Feb 2020 16:47:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZ5qk32hbRKlVEUPk2JsDTgTblsFRCIQPURrfna0XngO0cHoIZmK8W5Vxij2lVaaLbpuLBIj3zjZ5ji2BsmViDjfDAlcnvYhyLbq7aXlkIdWEwAsSX0nIEZ8n3GWkDdhRJf7J6nLm9V7oydzRqperzuUCfsJgRBxNGUh9SdDShK2sV5kq1iWlqRikHrn0k9/7NyPSfmEUVRceQxVaIQC+WGwewkn7p/xva3JiUZPWFXt863d9JiHEWCNkyIcIRWP3sLCczip2KOBwlpJ0v1KW/cR/Sbo8RPtKZIxaGRx7YjbylzpvQYsceqoH4f+7OhOpbrsuT76yhsdQt+ULoaOHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=n1BNFFwX5MSsd30yZTCT10gSVSLJUY2petu8dFkpIAUu2Axg/VPqPRd/J/qOxyVT3XxWficbxldlcxQ9fUJ4pG+63S+DwVByiChHBSAvJhTY20MgmXcNHIqIKgG+rRtrOMqfbQOISHgwTZKgBTsMVsxXWYK6Pn8Z7YcrKStaMTQ4YuZDHNDb7BjmdvzCEUUwLmevtyqnKnyMsQCdB4UDee81I17P0CWtpN+10gmMMbIuF84YqJcpTSH11az1tREC4PrIgq+1fxY76n4hTR/vIw6/xeGMNx3FwsJL2apuNEYfC2s/aa2HkpU5a8dU0B+Xc7a5tQxxggRWFVxUHneZ7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=xAWID/zAUSsPHnulga5dSUMT3me+sO3YZlkRkzuc/k7eg+zdtdNWfbq5uJGqVuLAr8mJNnuQdXmc414lzz7Cca26WIhPnkrAfT5LtQoszkDrzq6uWeTLsjWNeuxCxjJmViCFfmBkRuCvxALKZq/8ouibQ9HzCdtONuwCXN0ZnkU=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3583.namprd04.prod.outlook.com
 (2603:10b6:803:4e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.24; Sat, 22 Feb
 2020 08:47:36 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2750.021; Sat, 22 Feb 2020
 08:47:36 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 07/11] btrfs: raid56: simplify sort_parity_stripes
Thread-Topic: [PATCH 07/11] btrfs: raid56: simplify sort_parity_stripes
Thread-Index: AQHV6NRlZckXMTgvzkilK/+syvl5Xw==
Date:   Sat, 22 Feb 2020 08:47:36 +0000
Message-ID: <SN4PR0401MB359837925C7E0418A7C836219BEE0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1582302545.git.dsterba@suse.com>
 <1b125ae0b051c8b4075e9d6cf11c062cdb30dd8e.1582302545.git.dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [46.244.212.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 136ef434-fc01-4c03-a58b-08d7b773ddbc
x-ms-traffictypediagnostic: SN4PR0401MB3583:
x-microsoft-antispam-prvs: <SN4PR0401MB35831B6888B5248F88258E1C9BEE0@SN4PR0401MB3583.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 03218BFD9F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(39860400002)(396003)(136003)(366004)(376002)(199004)(189003)(52536014)(81156014)(110136005)(7696005)(81166006)(316002)(19618925003)(186003)(4270600006)(26005)(66556008)(66446008)(91956017)(55016002)(558084003)(5660300002)(66476007)(66946007)(8676002)(64756008)(9686003)(6506007)(86362001)(76116006)(8936002)(2906002)(33656002)(478600001)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3583;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q0/8f/aMeoxP+OHaEl5jzp5/7sVnFQnp919Lmz6B+77ooOF5GYeA8axZpNZb2MiNSHW+MZA/CbABLMlYUuOaXpWZ1fLqh9Ct1BaGeYe4a1A9zOrwCi5nRWLVCjsVqtHheR6h5oWcXk9WF/UifkuY1I9l1GFsaWJsV5mKwpH6RP/ywHGmFYa580Lmws+vmRmwnwrc8WusGAOZP2gx37qUOLNTGoU+w2CFeqzGCpAXUA20AxdsaJhh7HG7jZwIWD8gy87Dtbqje/CkmtCvG/DYr6h9JVk4YMY1OVPLcC47w3HI5+RA1ZjeFcrv36OX0Msoos6EK1kLUCyz5LWFv5KBq+CxGEEO+pQKPxQyL3LYkYdCcDWTm5TilamFi/5Y9bInqE0eFZP2+KDw/IrhzZyjPfsJzINXGSHGBSEkEVd7BDLxnYlDyXd920TE9EuGzcN9
x-ms-exchange-antispam-messagedata: y5qRlHQErPoK7Zm4tRWbi5A9X86GkBDtscy5lWm9wHt80bI1xza0TonlZZ/VlJm5+xk2awkRIvE5kdP127pURKSwuJKGdjqiEYDklmb9W66mUrSxkNY7IWSzkQ8Fv+tdUKrYgfWbYtfBI7x+sjDwag==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 136ef434-fc01-4c03-a58b-08d7b773ddbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2020 08:47:36.3885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k0i5Ca9HeBTUs8jHq4iVNZ06S4ii6DZTlwkQlky2N2ZwsUdHCyYxlBPwuMPyrHBj6HH90CBiQ3LdEVPedOjfBs8pocsaitMOVaJFU7ZBhnI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3583
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
