Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFF7C48C095
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jan 2022 10:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351862AbiALJAz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Jan 2022 04:00:55 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:16555 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238082AbiALJAy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Jan 2022 04:00:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1641978054; x=1673514054;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=frcCV1k9oG9oKj3dpUqdJg1PxRT2RSN/XKdLCPjaYaY=;
  b=jSTFJe9cl4+ProbIPzqJMykk1c7nPYi9MkEzw6oVA6H29al0J+vt7DTg
   Fus5Dn4CFbt0IBvyF5fvtbNR1gRpKCG/WJV37u8W23aQWQr0RefKY+j7I
   8ERwFLb5q5AfABbCfUjNQk5jqUFTfWh3Mu7tIP6Diiu1RvVZOAaM7MJUL
   ITqTBIULdCGSeb2oGPmv7dF1OUFE5wPpVbDe4o+vcnePUcdsgOiRHHE0v
   aelVrnD00SMdJVkZgeFN06LP04MozO/CtqTgUFuusjD0phiGm/cj1ru8x
   Hk7LMsJMwAN8qUxc6ucT9P15mYvrbQfI7ESFz9kjdOXlN4OUBQWdAov/e
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,282,1635177600"; 
   d="scan'208";a="189231586"
Received: from mail-dm3nam07lp2043.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.43])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jan 2022 17:00:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MGLj3t8GuOkyhq3czVwl+xha6H70lG/7avxCshCb+1iqxWQPk4CkH+d7YuaiB46nV9cgMPNmb/6MqbUrCAmaKMmCC7+PV4ZQ2MDX4aaoJg+NJ5CToFaJdqJJziqCgprjCkOgC0IMXk27LxxQStuaUwgfSDLhYSNZZhOF6KCcSF16pss7yveJfghzvueQI/I/CkNuRPDTFPVV6KO6vximjORIwSSpdLKoUXRWTd/NtM3wxkPdXGZSSWzLzbROPY2RNlBwzO/fhZlkxTEkH59IS9CAvNgyaYTNPfV/jPDtGF/YmMsRTQHMKXM3SL81E5BxMMPomIvSZupqcwk42jNs4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=nGZM45Yn3jiDwlmKGupqKzKluJkJnrbx0voJ0l5RiNZwB0/Z/13BUbEZqDdaAc2iB0kBoDva3QPf774IHB3wDl7cU4MNLxOWYvYPhl3lCTpqbgKhY2DWU/oAkD+KYIGDIQME/OkAmziQmNoQtD29eRlrnYLZZie4r5gIQn2Ufp8/qn815plwHwwHrUX/IEmBbwRwF0daMm1KTKVFFL+7xNiybnp0PEMOn3GNxIn8mB4pNL8sBXzFuBc8o2EfOJ6IJyUZUO6gsVDdfeSR1iUKapgSoY9oBCS6KVqGosrGxtqfpMdrcEhIogrHVcE+X9X4sAcZdPlCCuogHF3sS6f93Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=ZQk++psuNEOkcH28Wt/FcKbooOZh87WLOhDqJjFFj+hLeXo7QFFzTqDukzklCggijYXYwPPlbQWOGc1dSfA1G9MDX+ANCCdngH34ogAT+xkG7Z7njuRoeB1fwxMEOpjGIL1Ky0SY7ZJsB89iAVlE1THUUmVfG2OwSuCo3TtF3v4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7447.namprd04.prod.outlook.com (2603:10b6:510:1f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Wed, 12 Jan
 2022 09:00:31 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8d9e:d733:bca6:bc0f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8d9e:d733:bca6:bc0f%4]) with mapi id 15.20.4867.012; Wed, 12 Jan 2022
 09:00:31 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 00/17] btrfs: split bio at btrfs_map_bio() time
Thread-Topic: [PATCH v2 00/17] btrfs: split bio at btrfs_map_bio() time
Thread-Index: AQHX6kkvn7e4gQGU+UGEWJCojwlgqw==
Date:   Wed, 12 Jan 2022 09:00:31 +0000
Message-ID: <PH0PR04MB7416DF68B2899E2AF198FE219B529@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20211206022937.26465-1-wqu@suse.com>
 <PH0PR04MB74160D826D891E5E543603769B709@PH0PR04MB7416.namprd04.prod.outlook.com>
 <PH0PR04MB7416374BC39FEF504430C1D59B709@PH0PR04MB7416.namprd04.prod.outlook.com>
 <253c767a-4599-94dd-1c65-34d34aaaebaa@gmx.com>
 <PH0PR04MB741670CEF6419687BC70A06A9B709@PH0PR04MB7416.namprd04.prod.outlook.com>
 <64e131e5-bb42-5b42-d87c-bb4048a44989@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4351dc0a-6d81-46d7-82bc-08d9d5a9fcb0
x-ms-traffictypediagnostic: PH0PR04MB7447:EE_
x-microsoft-antispam-prvs: <PH0PR04MB7447D5DC35F324B5E5F7C7DF9B529@PH0PR04MB7447.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yvif1691NjarAifrMPXpzvCyOiaUkfKeyZLI44AmbyF2YMTcOIe5XYF3/ylYepDGhemrT3j5yXL/8g1MxkBST+HMrQUGl1cqp0/wy5C57gJZNoS9x4DVFwVW0YIL2uuFFxomwH+1HXoxoWIcJnKvGe7J7OfBwYsCbvvdkWojphz01SY3LbG4QsORP9RpPRTL2mxCxd9BX95Hg12vFceYjlltqUriMrSGu2qxzy2/LsFxt76sTjnF1bv+dvIOz4cfdABqk58PzbO5v6pfdycOgNsLlDfH3D0FDVCguh1yjtJ+iL9hxC+7NkyuD2VV0IsH/zHVsh0m3rJwTRQCC4glKvQb3W+8Nre5m7nq3uMXsEkLtkUevZgdK+yOlK2K4ap/1XYs6k3Tmbu5gxnpcLtYZuWWHSPu9vWNVudb3m2mGHAt9jckcsb1fUW+EjGxRTZ9y6thQxZbj9lUVijh1gIQxA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(55016003)(76116006)(91956017)(86362001)(66556008)(6506007)(316002)(66476007)(66446008)(64756008)(66946007)(38070700005)(186003)(9686003)(4270600006)(52536014)(8936002)(33656002)(82960400001)(110136005)(71200400001)(73894004)(122000001)(38100700002)(7696005)(2906002)(508600001)(8676002)(621065003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cA9RtLiw2LcJXbKPNIEc3TricqSdKlVlNfR38GbBXp8FCMNMk2PWXs+XVU97?=
 =?us-ascii?Q?nXVfOT1iwJ3dbUyrBbW2VmQa7EqFWIiIcLI0pqXiAJVGERw2IwtSiEEbKAtu?=
 =?us-ascii?Q?A/JFc+h2YI0ljD2PjQop48lQQ0pOMJOdSpy/3h7fyAkUSZsDiwxa2HEvW2r8?=
 =?us-ascii?Q?R1xM6XKB4zhRLRp92Bv4s4omQ9bXpPhwG/TePfiwiLyXL0hSGSLX7pqDC6HT?=
 =?us-ascii?Q?yMVzF/G1swLUAK+cm2/Ta9bYKETEdzPBrYaJsRVOfdunC/cXCsZh05gOZgz/?=
 =?us-ascii?Q?Nvq/QMXbBQ58ysCi9S7ek7i/MFXihR3NchEdS1DZbp6JI7VqQF+XnN3u8vhj?=
 =?us-ascii?Q?FD5aBGBkQoLS8pdn/dVDhsh9LzlK9t6vug3rCc9N7fv4YC12YqXzw+FRcaDE?=
 =?us-ascii?Q?eakK2Ou/oIf8siHfMBAo1D50tCHp8VCmpXkigPx3N7C8zEVGbgufReX/r5PT?=
 =?us-ascii?Q?qi+Q10h6uiZ7jo2CIh2sfFi6SUy7o7r+FqRCefYaUxo9S1xmsg8Av/bJCW4O?=
 =?us-ascii?Q?CswIa/kZHusqXDk07MKvn/R8j6ELdYnD11hIuYemzkjb44a3vrl3hnl1kNBB?=
 =?us-ascii?Q?IehMtqNjYP7owK2fd0X/tQ0M49jI6Smvk4UMcphnDE3cmcZEEs3+2vzUq6Cf?=
 =?us-ascii?Q?eB0F6qUfAIjfHW+SaoYbwd8xAwjLgS4P5p3TaWlHRAk5iZjczy6l2AAQ8AUT?=
 =?us-ascii?Q?SdD5/8qyLZzFYGQmM2xXA0/A3WlGCFKgxshUrKBQKe5YPAfZQ+59RQxvCst3?=
 =?us-ascii?Q?9zJtjxx26nTkwpiWXeo21DyPX7mzV4jfEoOts3pAC9fhvCNg+T2hAL9R84cO?=
 =?us-ascii?Q?iJX57heT9gxmiip8jk285Yf5d05UXfRluwda73gBq8uLX/MmIhsaTpvIHL2s?=
 =?us-ascii?Q?ZUiOsfTKeuNAiicbMOsVFrDDmODqE3LIavBDVpocLj+wlfReuPWTACdXXRMY?=
 =?us-ascii?Q?FRTUnLCes6bieVDa/48oBiroPJOnGItGef8ZgQqng4o8+VQ36tEfWowGnuvX?=
 =?us-ascii?Q?fzOSkSpv4nZ98mbuEKIDiZ1hNT6Xdi3WICj+IsvTxx4tQpvEJUDMWZLZsWe3?=
 =?us-ascii?Q?5S8on0GbBgceLg2gTPdx99NQ02Lq90bBlotTsHJ4A+4R1eWZjK80V15qwL1L?=
 =?us-ascii?Q?8vQEPCAeFGk864R4x1GjSxJ20fyYIy0I7VpJnMQvmRCJzoK34+mVkCJuWcTr?=
 =?us-ascii?Q?95TelbbVXTLH9T4TRQhLfZufDFdB3QW/+N1ZxAjFfLd3OwmzfcX6AqgzzArO?=
 =?us-ascii?Q?orjoXPvB9Dltj7lzw/iW/1tm7Ygp8r5OMDA80jC6EmPAbb0SscLZDIoVBY+I?=
 =?us-ascii?Q?MvkiMyTFmuYD5lOfblmhL7zYZrzc7YyXl1wOSGORNbukvEhVHZtHhm7QxAUy?=
 =?us-ascii?Q?aJVReNsVuQSnrdM1Mwl8fzQ3cFc0qdsN6v6coING3wPdL3ddcQ2C79mStMFh?=
 =?us-ascii?Q?8fV9GldiyTAYy903MEWQIlWX/IEX2OnHUhO2gGrJpi3nJLnIh0spG7AUV9V7?=
 =?us-ascii?Q?H/8ObDnpqiL6pNZo+LvLcFwWUX0KlqMGQ1RixRKn1ROqKw5rJitNXcApBdKf?=
 =?us-ascii?Q?MgPELjuSC09wy515bgkwtEcM4WvJ2R4D8rEECjteeAAZEtAie8NubmH0lNb1?=
 =?us-ascii?Q?/Cpqk3tpfYGaEG4xjsbEfmYQUci+y6udTMU+WuHxGauzgpoXHLru6b24Gigf?=
 =?us-ascii?Q?NHIFpgcSblT2qW0Znruacb4xSrqhYRsm2B7G5jLslOq190LRe2f49oN6hTts?=
 =?us-ascii?Q?hoYxeQSqF9y61kkzu2BccYVVVgJiQYI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4351dc0a-6d81-46d7-82bc-08d9d5a9fcb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2022 09:00:31.3845
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JJpzgNiUavIL46KMAeRh0j1B8vQd33kHM8vSUCM/G2LslwOW1S7RfThgcl0Pkf4hgdwXasVZzG1C9chYTNbmxfljqxMdYl5KJBSRWxM6iiY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7447
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


