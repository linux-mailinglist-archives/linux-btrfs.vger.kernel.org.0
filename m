Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5653A85DE
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Jun 2021 18:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbhFOQC2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Jun 2021 12:02:28 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:8854 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbhFOQCG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Jun 2021 12:02:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623772802; x=1655308802;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=Envi8JGVc3SSw4PgBVbrvOOZoXcHZrys//VVwACJV8IkwUJhGJG6AvqR
   HLBX5e9/xj9BKRc9syePppI69/AEKMIEd6ln01JbOKcTtnPfMHaOmaqYB
   YNMcCQhcPIJUUIiMcxNzerV68IOgAdtNO5OPW9j7Zu28++PolkZPtfNID
   3iKCtCVti/WSw2CJsfhcRy8wS3j5Ri9lSvKCk8m5AYOm/su3HP747ECNZ
   Q7HzZvU8jUt1q32i1R8NGC7cKYW7UObBpKlt8XEIdo9kxkfFBP5tcAOpK
   +Cg5I3dLL9Zil1ZWJp9wdh25+RdaxYzH/0silW7QUN2SZ8+E1imUMcJZt
   w==;
IronPort-SDR: 8WgTMbLM/fktZD7k/L1j6DVC1/mBajwfJcXhNH57wvtjoqtrqp7zkYyJglPml3WUz424wvPuPG
 nkCSdiUvNn4GB60B4OhFxhiqwaBdHa/kMr7HwPyuiB2LScqdx7s5RmXZPuVUK5tfNu35m5s5Ys
 O+Kj9isXpIBnQygrrdc8eArdgM5CHM0IaNb6T2uEoCWl80o8E7g/cOuSxzmkms+ahGK5ebIcjn
 Blv501gfKgEEHuPMFQ5pr5tNBLVPzRii2oGaI1JGZXug/FWNaQG14pu/5bhUPODtIJSiYNKENM
 uW4=
X-IronPort-AV: E=Sophos;i="5.83,275,1616428800"; 
   d="scan'208";a="172546714"
Received: from mail-sn1anam02lp2043.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.43])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jun 2021 00:00:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HAsofvSfK43enPx7YqUzkDOI9rmi+t1WbsKUZb+MWQRJOjUeACGfU5/HK1BSEt7LdumWUAmcBRXW9Mzp88mhb0hmPxG1vS6xpLxHOTpNrJDMXw+aqb9/i5NbChC19/AJppuWRBGqwkg19j198IUKizaUrsows9i6xFLA+Zxz13+QGLldEx5nU0IHbhaBxuDedEg13z+1srMPDteKQB74k5fIY5ASqk4sUgzUhlrZG6qq9EkNB7G+BbLCJdNGxBGL387UDzzI+Fp85c5Gz2Gj5HzNal32MlJ23rsxYSXAn3cizYg5DsBqBB4Ssgnb1c1lzNHlemmsW4MyBOxAiVQVOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=J1I76NFDAxMRv09ezk9Edm+SeZorxHlaXvB/XRSuAXVvjRVXvQ62MG2Ejx31BAkGfFx8HiMc9UdOs8PosUtrH5AC5sbY4iB8gJQK+wP0e/rKr+2Z3eWJ/sp+sm+DloKJDGsZob56eMQWGI5RGoGuCzthB79DTyx6CkJdaI+boFI6L9NDwOpisYlMRRSaHjHacMTF0d52V4UG9bcLSPh6j+hHiDACDeYHRRnXn4S/rgB9EpT5oGYTbUBQiMO6x9eollG2uyNUHmlC3+9beKHOBIdEaMVQt34COBdcZ0Md5+fbWqbpBHghht7bHIKhZ6cgV5Tv96eK2AO+IFWyuR3kBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=IUWya+Xov/euwVZXeoa0+AoI0e5M4RVd5IqvFc3f8j1OBY++I+UPhbfb+hejJMSjOIgz0VtmzuTwu0kdUmfPLRBZVbkiN50ajlPIDWIX9jm2pd5YeuTgrqoI6aWuptkA0bRCjwA92CkJxNv8IKgIRjYpm3B836/TDVdqzV6qbV0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7254.namprd04.prod.outlook.com (2603:10b6:510:1b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.25; Tue, 15 Jun
 2021 15:59:58 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4219.025; Tue, 15 Jun 2021
 15:59:58 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 5/9] btrfs: introduce submit_compressed_bio() for
 compression
Thread-Topic: [PATCH v3 5/9] btrfs: introduce submit_compressed_bio() for
 compression
Thread-Index: AQHXYeCe1QWm+LG/YkK0o2psmHGFlw==
Date:   Tue, 15 Jun 2021 15:59:58 +0000
Message-ID: <PH0PR04MB74160C8631EE0915A7C9CCE89B309@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210615121836.365105-1-wqu@suse.com>
 <20210615121836.365105-6-wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:141b:f301:b8f6:a609:8f3f:1503]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a909e638-04d4-461a-cc96-08d93016a05a
x-ms-traffictypediagnostic: PH0PR04MB7254:
x-microsoft-antispam-prvs: <PH0PR04MB7254CEAB03C1E180AB1AD59B9B309@PH0PR04MB7254.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EvuBdI6Y16gz6oCBgEPoIf9jrA+Zy84v8kUldORHq7Q0qi5kBYnOCl54dPlhupJQsj+Lk+MVgKkUmiNlDo5FF/pmAdzfi8kSVocrGq7d3sp/Baqk0M6QM8Rh62RJAXqiA6Fy4zsgUqtGLzqU+6vzPaBPAtIIYHd2FCvMo8/SCJEbbS2tvsu5Tk5lCG9sMPE/TCiAB4FppjavX4KomuoNZ5KgQKKWheHYyxI2wNUWg/ztHFv5AxuM/yE1j27hs9N1wBnvSgLTzwKFqXWjTI8ESpo2nRuwuy1jp/cWHRiCJhGSRx7zu2N0s3Ai3tbDW00uuAtMJxCk7n+Rx2O0gdH1HJhuVN0w4ZHWqG/p1yitz6FWOmvEHyYJ8QVD4jnKk0tsUX03+dMkjg060wz74A1Q0gy6G14GuXTGE9cIlpRiKQlURMOyilNLbdNaHgZQoUEBgRmiKuPgywpbf5mEvKA50Lc5fu208XWB41dh0AcUVPUBOsPNDTM8Xv6No3ySUOz4bkissZJlPGu9rIh5cmcx5hDhguhnt8A/bnN8DMq4b3oTnfR0wPYbshzNEuuJVxqtHXh2CtVoBlX3rjiAQmmcl5aWIz3iYingadhVklmW8UQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39850400004)(136003)(376002)(366004)(346002)(71200400001)(4270600006)(66476007)(8676002)(66556008)(9686003)(52536014)(316002)(66446008)(122000001)(38100700002)(64756008)(110136005)(478600001)(5660300002)(558084003)(86362001)(19618925003)(186003)(6506007)(55016002)(33656002)(8936002)(76116006)(2906002)(7696005)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NKiDDWOt/jnCNaI8Q9tAMJdulirY705lt8r9za8EqaEhXzA8ZoNf7owE0JnU?=
 =?us-ascii?Q?1sza5qu2lP/0z39sMb9aWH7ZY5y43FpvjFaAFXYqCG0wfzSZM0WPtZpeonMT?=
 =?us-ascii?Q?cCQ+PvtD7nDp9LWV6nnxNO+l9IV+2d8fT7ahOy+q0cXejCQZieMtezqZdVVD?=
 =?us-ascii?Q?Ddf3KeiCyinRIJmoq114YXi2ucwMtet6/20+6gOztw3yKBjsK01+c8b3Xybv?=
 =?us-ascii?Q?+XkHgvT+w9NkzrigaGBV0EI1pSyxa1c+DJrX8MfoviQNH3BRvTb/hw5vRAt0?=
 =?us-ascii?Q?B+l1fhmt+fqJXsI9tHCcYBARKpfr2IsDoeHzaeF8fqDqBnHkKlfmAk33gJ51?=
 =?us-ascii?Q?CGkjTeFk602dJQ56/YEufYQppVEGv5dc35Ov7OtqBFR+LkPWvtxjGiMs81hR?=
 =?us-ascii?Q?NLJz56CVHsjGXugm4cpFGZHJeZuywssOF9FuQkQI4mykaeXe6Gw/SQB99XEF?=
 =?us-ascii?Q?rrdq66iThGeHNvac4sQfsT8QbyDiptGY8Ht2FYf5ZDevlk14h/DQox5Se7AN?=
 =?us-ascii?Q?f5gvMlNL0UdT5py+DKYzZpSgXr3NY8DV/gHs+h4MhSeBKajQXfFE+33oGI7d?=
 =?us-ascii?Q?KotDdSISCIvMOJWv1+JpLcbyspJ80b2qhm1SpJpC9rfg2PHKE0OujfXXc5kd?=
 =?us-ascii?Q?zf5tG7bbC/KvKGQts6Uy2EQpAfmnAyjaBrTKnNlh4pbjdi/f0CFKyKhzCwQR?=
 =?us-ascii?Q?kQm+5I33gpl/E9WuUHX/m+v8gxHvsp2VayTtKV6rUcapbMjcllEsvCdsF6BW?=
 =?us-ascii?Q?HH2P+DbAG5FxMb9+69DJCEIVD0R6o+CNblwqwPUPuu7FMFpP5WSACOJFd5Nv?=
 =?us-ascii?Q?I/yansSkkHJmXqqfzzCPZLsNqjNcncIYR+y9uOHhcDp+IDlxA1mrbvoGRylz?=
 =?us-ascii?Q?jAUqpYuAlh8Dt0aC+svx8Lnwn4qHe4Revqw5dvec9Uc4RuSJAlY5+8xXYRVW?=
 =?us-ascii?Q?UXb5GOp7pcDM6CTb5mnKy33eC73M0g8U+Gn1J5f+n9iQL0AJo6AirxO3HgiM?=
 =?us-ascii?Q?AXjtKdcwcgUuk2Wml5u9q1C5X8Kd9kG4KFanKPvxp9J9yVZRgBWL0T25pfkq?=
 =?us-ascii?Q?qJfPdxJpxgwZz+P8o7LlCo4f9BoEItlojizPimONTZ5xwcR4qAyNv85Wv96S?=
 =?us-ascii?Q?gI3lWe0hI01g5uaqN5W6T6qZMSX0otX/zJkhUtW1ojIvYAxL7byXUuloJRaq?=
 =?us-ascii?Q?1y2BvAy/aOwx0RNVLHJV9aAvoROSgSGz9lKv8Zc1NIeeW8YGm9bQlVjgeDrV?=
 =?us-ascii?Q?2woDmohij+i92o4tmaM5szL4JvKfk8if4KLDFaQ6ZQ2nvfdFTnUcy8rhSpba?=
 =?us-ascii?Q?cVNmtiF/RH+oC2l1UIIvh1HcPOdE/WFz5hrM+CQqFZ4Lm085Z9lkTqESn4kZ?=
 =?us-ascii?Q?OOmIo/GwyKDVOkOH4bqvKDFEXAp7nhj/NRR0KmzbW0p1VHN4DQ=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a909e638-04d4-461a-cc96-08d93016a05a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2021 15:59:58.6020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZxBC6A6a5hHiArFZ+7SW2pFFtcjXnc/q8Zj0iJp00vRiqJ0/mnOsFdrU3DQxnqkvXQrHp2E4HBwbgojbKaTUHPKxLDKrIWmPl1bRMPF/N7I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7254
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
