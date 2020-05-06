Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4731C77D6
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 May 2020 19:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbgEFR1L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 May 2020 13:27:11 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:13380 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727872AbgEFR1K (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 May 2020 13:27:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588786031; x=1620322031;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=OUQoLW9n2ew0Qs2w2i+ZMseXb9BzWR+k7ynZi4Ae1L0=;
  b=cQsaGy093t+n/QRVl0iDPmJdWD5Z8PDymB8MRbAoBaCnS4jKWEj7Cu8/
   G4YMJyKJvbGDKSgl7wBmwiga7hHO/jhvDPM3cDKrzRPewlQKamAvsh7qS
   stptai81SvmngqsOXbyRoVcj6UaeY1JSdft7gcdhrMqK8/i6+3CLxmKrY
   gUjIInxDwxOyURUX56COJw7whzftlWMN7GyqkahlngA9GPtDdGiuf1TUY
   Mpsjx92xR2AoIdE/4HO1LA+mvnmUv/FRUfrGQcKR++KvfLs5QE+uw/Bnp
   w7AZsNlRSHhUczikaJa459nJu5IpF4LKyyGgeDjwZypgFBRc5oSMgIdm7
   A==;
IronPort-SDR: Bw74092fLbJKgUFILTXvEzgRKbrnZX14Z2/ne0FgrB7+dw3udo12ddZhCnZstI+u9ZbVxReRnr
 Mm7tsBvlhxpJob+4SIjG+R5VlpVxNpLUZI1RVSTiIDJ+m+VVN0nA46eSfviR1QmsRH86j0EiSM
 sCA6I9qGOsUhX0iQ7RflLPwwU63j39HTOL6eySGdd7nFzIXkfbq+pIonIJ2CqVxwRT0GOUo6ig
 u/yQZGYVJ1tTL20hIki3HtS1XJxFmgUlX4CLRBexZd/zxEK9aPXItwpz5rlda+GpSjoYQkuyg4
 eHg=
X-IronPort-AV: E=Sophos;i="5.73,360,1583164800"; 
   d="scan'208";a="137395593"
Received: from mail-mw2nam10lp2103.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.103])
  by ob1.hgst.iphmx.com with ESMTP; 07 May 2020 01:27:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DGnHu9KyrcgcD/lavE+mt2wg8SovXvjEbaSun6Uso2xf1cimf6qG+i3TH1gc91IbvnO4OX18BbQb4ez3GveuTxyjJHOnXjewEyvmGq77QnDsShc74YF8HdMnVgYCF5oIKWG0LQlGga3d0yl4p83eMCuy6vk09G77qUpaw7F0dZykYcGdja6ldW/0F6fsNl3CvuGgSQl/iFvhUAYI3s8cCgidK0WBWcYP3YjfFeUj9pTdmpMXoCDWAga8ul9fhTfvUseCga2nl3MVTOyL6pMIYX0vqL8M56QOCrMtEWhdTyRakHbOesyuAqd1s0wWc1sNURNvKQnCMDEKrDE8k5WHfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ozGauOgn53kMM8TT9slG6TmMPZSArKPXXDCpHWT5+o=;
 b=F1sMny2p627vAUl47d1c+zZW6RDERHNWMkq0XmoOPCHioriyM+HnW6Gj/fk7HWdzo/yZ4tTm4rAQrAwhfh4RtcWejAq1Ph1jlEbSKuOnRObjmccxzuXkZBdplZeEYMlbaFm9UbCEx6JU134Af3zbhQnAa9PGs24LHLKVfltjEsGdBE1YL219nC7LdPJ00DME8MDDcCACg+ltmvau62a6oe36xPnsl5VuXgkAs/RVS6JWpu8XJJs8nGq9hxq8Gf/RUdDvuMI0wy2Jjf5ccl1+OGW0CsLb8cz5MnqSSqZVtq+hduHF0lvG5S/DhG87w/n/QR3OZcPHGLemhWxNwQllHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ozGauOgn53kMM8TT9slG6TmMPZSArKPXXDCpHWT5+o=;
 b=ADPzSbgpMws2Yph0Ugij9l/fuAMfjWOndzXXp2Ok3YaxtmgMbOCPoClUFrvLNDzw2TOL3FdJ0CVb3sdxMGlAYBdFB/aa5Q3TTiXv2iMtf6Szo0fhnB6GtGAuR69XU5GH8sTAPIPWpgX+Q5wuxQ/DlB4oGtmF02iyudyKV9sPgfw=
Received: from DM5PR0401MB3591.namprd04.prod.outlook.com (2603:10b6:4:7e::15)
 by DM5PR0401MB3591.namprd04.prod.outlook.com (2603:10b6:4:7e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.29; Wed, 6 May
 2020 17:27:09 +0000
Received: from DM5PR0401MB3591.namprd04.prod.outlook.com
 ([fe80::3c00:be66:e289:10f7]) by DM5PR0401MB3591.namprd04.prod.outlook.com
 ([fe80::3c00:be66:e289:10f7%7]) with mapi id 15.20.2958.030; Wed, 6 May 2020
 17:27:09 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v4 02/11] btrfs-progs: block-group: Refactor how we read
 one block group item
Thread-Topic: [PATCH v4 02/11] btrfs-progs: block-group: Refactor how we read
 one block group item
Thread-Index: AQHWInCBjUiXawU6Z0i8TlfFRK8ocw==
Date:   Wed, 6 May 2020 17:27:09 +0000
Message-ID: <DM5PR0401MB3591BD0FCE7A13C5145BB7959BA40@DM5PR0401MB3591.namprd04.prod.outlook.com>
References: <20200505000230.4454-1-wqu@suse.com>
 <20200505000230.4454-3-wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 53e7e60b-0c5f-43a1-400e-08d7f1e2b4c2
x-ms-traffictypediagnostic: DM5PR0401MB3591:
x-microsoft-antispam-prvs: <DM5PR0401MB35912DFCA105B8159B0716C09BA40@DM5PR0401MB3591.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-forefront-prvs: 03950F25EC
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F9Vb7lOvM8OWJftkMjcbi5XoXzqUBBWlWMRP9GJMIqgGqKI7d/B5zMiF3E+obbA9bdbqXt3EgxXjxeRrh20mr1ZumzDcZJ9wMQLEQ9+Uo0dXuGzDdWwyk6fMghpexFaz6nmekWA90y2kuVNyOBI7fS4f6VmqvjBJKqtoc2fJeeY524TW+Fx+gHxK/78JqEl6HWMyAmu4+5w4RjFz4kiHutfcB5OpQKpYmc4oexmv7CUweKvdjKpC7J3R0dCO1OfX1/7RYD8Cnsd/kAo/rDyXnz55HCLw88ieI0uWpu/Y6kHdtOVBy6zsVTOyyXd/YgT3KkzdU7RKXB2ZHKVURACRkERwBPwYaoZ7AfaP4M7X+8tLfnTfW+cxFUfrUWDyNTvhAEAfbjGOtYQsUs+DJw0vIe+5vSkjQ2Aa9zZdoMW00wL6J414WyLbZCrr4pN5mGYMn+3Yveu/Sp7U80u4QuSuJlpyxb3KaQTCTXnfH2icGn6zwo21o82WaBesCeStHP+k5Gz7pRyX6qN/EB0859AKNA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0401MB3591.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(33430700001)(186003)(7696005)(316002)(91956017)(110136005)(558084003)(478600001)(55016002)(76116006)(33656002)(66946007)(2906002)(71200400001)(8676002)(53546011)(9686003)(33440700001)(8936002)(52536014)(6506007)(66446008)(64756008)(66556008)(86362001)(66476007)(5660300002)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: GMAfxcIOG81wkW3Bi4v65ZT0Luzz5IJT69LXuaBsB4t6JgM7fiM6McqAEafqAQn/7ISXXF5jeEqAxTd8BWyK2MfOsV2v9uajR6nqKuKCN7dsyOGCTHFdSIMEzOiH38h8+hxgnXRceQm1Kw4gUbFnA2Wg+MXy68LlOXyU9b2YM0G3dPJyOWwZUd15Y18jhk6dacmI3crp9EgrsBY8+wnD6dpfS4cJbi53v0lgBmLbYtTLn94BxrioKYAUoekzb1yVdVP7KA2YLGrPHFNBzmHEgNI2wTvHljR3yyVITqobwt1EbLzkLiNBJQtl9q0hsdDgU5GiWHSLoxDZWfbeBIbmfqq0MbHpk3owU1rC81XyQCLu2FQuyMYkP+SUycocLjwCovkdkac8Qsa8xLdh2tpIpJIQ4bqwUGWLGKOXnqaCE/XMqzfiGb7ECx1e3N06ZkbLpZHIciLxkdt9C8FYOgI5YCQVi5VbzLoFqUlTDGs8rWEswQs0xmmhf/IL5t/9yPb7z0FrhIE+6xfJo/J7B6BAByUkHMEEvZF7G+ePK0idnVtob9zVEyd5QSbyD9GaehjJKRZAE+OmI8h9yTvIPMytqPXa37c0ZudoxifyM7eSJvQIkAxBuMPT/rNu7FrEfVSGR6h+ohTdqGNsJmSZL4PRHEp8YSCcitJEkMy9uYrKBWZH7vK+S4nXhHoagKmKmSwK8BMcb8HGCuSOnv/KqyRQfXoCNZv4EWkQS0ia6VrESG3TbvfC+FzP6mQw0rHDkOZmGfgvEyZlCEmMTrKL13KgTMI1q0OXw17HJvbCO/zwdPk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53e7e60b-0c5f-43a1-400e-08d7f1e2b4c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2020 17:27:09.2327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /87NQpIeB6FAU7Hq+vwHXl6ug7ZbZu81RAqIfueRAJl/2Y+5fHbnAhwDcoav6ZI38xrKPTQffa+857DKk2o2aP1wIbxIQVNyPDsaXUOgkrs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0401MB3591
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 05/05/2020 02:02, Qu Wenruo wrote:=0A=
> - Use btrfs_block_group::length  to replace key::offset=0A=
>    Since skinny block group item would have a different meaning for its=
=0A=
>    key offset.=0A=
=0A=
Nope, you still use key->offset for cache->length=0A=
=0A=
> +=0A=
> +	cache->start =3D key->objectid;=0A=
> +	cache->length =3D key->offset;=0A=
=0A=
