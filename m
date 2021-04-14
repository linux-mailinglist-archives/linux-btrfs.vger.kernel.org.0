Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B231935F46F
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Apr 2021 15:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346540AbhDNNBJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Apr 2021 09:01:09 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:59068 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbhDNNBH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Apr 2021 09:01:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618405255; x=1649941255;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=TbgKo4nzZ3p8bmWp6WQFRc/vRvYUh5TMsUq8FQ0vKAs=;
  b=gf6EQl1g5qAtXKgcvb07d/cWdHa8bo/pmVrJCXslm5TVooCD8KAE4LSs
   yKS10GTz5bvCh3QJBogCdfjiO3giJ9uqWuiPeFutsT8is9swsi89PMt0Q
   V+AaK+oYFOXKSKtF9Qh49yFI+VXz2pT46DlGQJ/Bpgv26PJRaPSuM7a/i
   6Qa4r7uJUKNJM1XeNhsu+E/1GBQzw3tovX7Vt3ArE87EEIrYKiYHwxmbI
   sUGlHoLhhGeiDl2cuBLD4S1+raWBesPzxXyNtnQhD8qvSUOyIZfzEVvGq
   rPQRLxx+nuQ3hOnSqs2uAacHJf3fhzQxrpQWGi5jPXXn4VD59ldzxetC9
   A==;
IronPort-SDR: INoMlTjogMcjfRoaY6ujIuXrEgfGPHApX2VSx9ud4zI1T5ozUAIKEJXQ+LqHftT8l+rSQYZYBP
 Q1hcu5rpbdLDJWT8RkNiz213OhRj7kGzgDLEhEx81nuLRODZmwlp+QYsAeI2CtTFUs9IN+TY9F
 4oMkiQ2d3vl0VjUSAVm/VPEV4HmjwwW1iJZeIw4xIu2bNa6UmhT3zuDc7bhqksYGj9eIYq5dlk
 AlLUbeCXgvip7Cxaj+LGI+rJZmcBMs2pVttX2EbALC9YKbvBwxFZpH8rfsHHU9wgsdGKJT8Wte
 PD0=
X-IronPort-AV: E=Sophos;i="5.82,222,1613404800"; 
   d="scan'208";a="268917581"
Received: from mail-mw2nam10lp2108.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.108])
  by ob1.hgst.iphmx.com with ESMTP; 14 Apr 2021 20:59:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z+Zw14vMAyixNNBrFg4R41dH3Sjsl8tbhgcknZLVgU5U6mUFSLh37E7dopWH5tVVB4s3oNWTu/TO8Y3lzaQmcxbRwHNIJq4AJt4C5iLbRvsfMeUpfqnBJvXIIgj0DpG+gXWNFrxYQ0RgUCykVpd/LfdNbTGN5auGhDd/G/P3quVERIRuOUQfcwLLCbutUcGBsKZ5s+N4TKWjpq31kTWwcGoY7SKAbTxasTElkIOMcLAj8TN4alZT1hoc4FuUkjou2dcBbpyV9Ly8ruYjKEpVg11Nea8UJHTfpQGOSR7DzBvqV5GHfrBuAPl160AoiqHs04UFPTy+MHr+icViOfSfrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TbgKo4nzZ3p8bmWp6WQFRc/vRvYUh5TMsUq8FQ0vKAs=;
 b=ShB6b+vk9axVGR5QpyhJLeLYsyQMyPORBZ2w4q5xer1zSSaBI8L0KrJPNR2iXx05ZI/OGdWn8DaJq6rRdAQZT+tgVeQorrVSeHkkY/A6hLSUpdRhD5i9KgP+BacW//FVoRFIjl9QA5Vq/GzUT+jmlm67VuAq5XRe/KaA0YmjqYYd+M+qGIbvsLdsZ2gIxQm3690BMuBUegkK5QAHfSaPUYliwzoHRXg+Lnh22mE8aovZA1vzGerA6yDCq6ttQaX0aA3wiO8OUEfkdDYt363e5e/OYqQRjovN4eHQvqO10RJBRr3iF3BfKfWlWfbQnmRqEUXgD7cl5PeKpsJNUsUbpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TbgKo4nzZ3p8bmWp6WQFRc/vRvYUh5TMsUq8FQ0vKAs=;
 b=cQcpprHkNM3EXTd08VwLm4D399PeGrnX0MmTSD9ix15O2NPePZvimdvijKFj/0ugWzT613e1P0zLP+FnKSiaSsXbI+c7AFiXpCcuhQ3gSVK1R1XaY+MfYzysvE8m36p7BYrhMwKbZ/GB7hz6EMZ8QU8cJ/SdRDIqQJXTJFWKv8E=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7477.namprd04.prod.outlook.com (2603:10b6:510:4f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Wed, 14 Apr
 2021 12:59:24 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::695f:800e:9f0c:1a4d]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::695f:800e:9f0c:1a4d%6]) with mapi id 15.20.4020.022; Wed, 14 Apr 2021
 12:59:24 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "fdmanana@gmail.com" <fdmanana@gmail.com>
CC:     David Sterba <dsterba@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Filipe Manana <fdmanana@suse.com>,
        Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH v3 1/3] btrfs: discard relocated block groups
Thread-Topic: [PATCH v3 1/3] btrfs: discard relocated block groups
Thread-Index: AQHXLS6OQPw38ZTTm0ORPeiHMuNyDw==
Date:   Wed, 14 Apr 2021 12:59:24 +0000
Message-ID: <PH0PR04MB7416BE8A6029E3E6FAF8664E9B4E9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1617962110.git.johannes.thumshirn@wdc.com>
 <459e2932c48e12e883dcfd3dda828d9da251d5b5.1617962110.git.johannes.thumshirn@wdc.com>
 <CAL3q7H4SjS_d5rBepfTMhU8Th3bJzdmyYd0g4Z60yUgC_rC_ZA@mail.gmail.com>
 <PH0PR04MB741605A3689AA581ABC6CF3E9B709@PH0PR04MB7416.namprd04.prod.outlook.com>
 <CAL3q7H55vudYBNFGHWWuWCaeMLuVm8HjbBsmTYD7KQP_dKEKOQ@mail.gmail.com>
 <PH0PR04MB7416DD1B232F797944ADD6EC9B709@PH0PR04MB7416.namprd04.prod.outlook.com>
 <PH0PR04MB7416807F6FA29B03EF6A4A7A9B4F9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <CAL3q7H5xZLhHrBPJb5jwe8ZxAv=XfFC05kcw5-WqBySQP4uTBg@mail.gmail.com>
 <PH0PR04MB74167FB19522DBEB1F70E80D9B4F9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <CAL3q7H6Bgqkdf8Z+xRBH8C=XxtrGzXyNUf6BHaLw54LZb3Agsg@mail.gmail.com>
 <PH0PR04MB7416EE187963A0D7718D57979B4E9@PH0PR04MB7416.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1eb3cf05-5f84-4e15-c837-08d8ff4520fa
x-ms-traffictypediagnostic: PH0PR04MB7477:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB747712ED710A239A4641153F9B4E9@PH0PR04MB7477.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NOWYlMtu1Z3fm0XxRMvQg/s2bISrz09SQPxZeQlBmXcD6vfgWW4Z3t3simVih3KnBI5iuKklxJ01QqyLSUb9W5WzjZBDTZJ2KN/2fnqf/BMCFXkaE+DyCBTpPeKpgtrrET8bm1iLmu2owjT2pwzKlmOoCxLbWHTXrCq112WqrxzoqRbMcp0sZPvH1H8gQJJ1HtljW1jK2iLv5WfDT98rVZAFDkQ401E/KpBBs1A8PtxNjMt89pv/E4f4SOoIXWX5CYr8onCa3HNV2pPNzaAauURFu9Cst+/HHhP7PAi/wyGIhQ6w05r8dQqHWsGp6B5p5s0LcPNr2JhvCNUflSzg+rWQzvMHhMPCJk/yoTerr+0jHn3NpmhMu7RWJLeSLwSNmetYLwmmE2T5H6x6OejvtBd08HjqYRGq1yiN5Zkr8NR9wQ2vvDt+EgKnMEJwHU4PCr8tk1ZVrwKAUgd8tzuOsGItgaZ36AllwkHlCiUKdTW8GNw1pl+uJ4IGxZUaB/7L0JiWI9UnDyFPn03sBVQiMLOShHV8mzQ/OsGYRtZoRqGhmkq6zLJfHyEli17ISrOqw2hBFI/3UN78xTC+A0AIRYTN2HBiSEvcYJ5G87Pg/y4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(396003)(136003)(366004)(52536014)(186003)(76116006)(66556008)(478600001)(66476007)(86362001)(66946007)(9686003)(66446008)(33656002)(26005)(83380400001)(5660300002)(55016002)(64756008)(54906003)(6506007)(7696005)(316002)(8676002)(71200400001)(53546011)(38100700002)(4326008)(6916009)(8936002)(122000001)(2906002)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?n06VGXXWsEPFQleDYBrt2CRKSYLfjjpoYnjT00F9M4pKG0b9rLz6lFwH/Bq6?=
 =?us-ascii?Q?h2+GHTfqhHdmMVQts/aj/keUuuElzIgVf5t5G5Vj8k1r1MYtuUJcZ/OzeSzQ?=
 =?us-ascii?Q?Kr4aKjV1AoRi3eM47tvk+yBr8b/DY74UYTYDZfOwc3U0SclmWsfYsuBuGvu7?=
 =?us-ascii?Q?FVtmCqRUsnzn/EI5cAUQwSmZUjKWWGZLQbuP0AZoxY/cYSWYwyF3SLHDxVEo?=
 =?us-ascii?Q?4X3t4feJ+qQqe10/5qU0nEITibHfydYOVeQay1YxNOlbB5mUr1pO00Yco4EL?=
 =?us-ascii?Q?sEWZ05BymStLLPzqfuSLBgEZpwdH9/jVYo7/UWuWc8rcZW2pJDGztszOsdRb?=
 =?us-ascii?Q?6W11ekohHGleMNGFbc4Gbkrl5KA8paEYcTU7S1QJAL0+/rVsBDlmekXgzlXw?=
 =?us-ascii?Q?e4sh0i9oFA0VwHs2e5mLgz9uPDop0mYttg4gE/w54fPspipFEs2OikXh/BKe?=
 =?us-ascii?Q?eq4/hC4P4+8efFL4T/SgcaNNy8Y522owucxcVp5+X9/EqPdheS5khI48bBxF?=
 =?us-ascii?Q?z6ctI/cUnyQfZ4LhlmqDH3w1hASGlKlaZs1NFfzvB5QEVOUTQ8STq+YN+lBC?=
 =?us-ascii?Q?t92rym9ufxSNFHMTK/apjGRnrkhImeDnJ7Bfll9Ejiz2Fqq8Y1EV9VbApP4n?=
 =?us-ascii?Q?0AjrHLCdwgKi6WVZI4Gv41u3638fi9ZZegJZPwAJGjnOM2kUCeITSEJlSVQ4?=
 =?us-ascii?Q?M+osCFXSaR6Z65HIH0pAQZu1HTJlqlkrjgWNrN8qz4o8ussf7iOIkdrqZN7T?=
 =?us-ascii?Q?kdPSYk20Sn/REZfxHKj6fYZovoiA30gro0/2PKNaWDBQ+wgRunuhRnCXaz0y?=
 =?us-ascii?Q?y3Hy2bIEi2tS6fAulSvZLN7ErcJOKlLZfS3GZRsKOky4ryPXzbXzb1QRUlQe?=
 =?us-ascii?Q?lCjK8ifENwcZrz5+P2ox1kJZNDgH6OWv7hJhO53zExzA7CKMM0/5WXaRU+UD?=
 =?us-ascii?Q?5ylfN13OYxmai+QGOopzMaYGEWqzx1FQWoN6F/Dso2wSf8CI/vdqOe/kju/k?=
 =?us-ascii?Q?lFWnwjp20hPG3rYORVN3XgrMHwfvu+n7usjB40tNPmMngLZUarMFVhDo8rIS?=
 =?us-ascii?Q?O8TVyHo4rigxw2xOtpuEey7mdX+Rtt4pDmUOBp4JNZXW3t5Uz4CpNhLIbKCN?=
 =?us-ascii?Q?kJtqos0oIbasChbSd15Nu6CUMUxzYieTOdmNCB5lo8beF0efpHDC3yfNpz/F?=
 =?us-ascii?Q?qKlGSIOAsogQfQnzyRjy+l3Fatln7+bytYSBQTEqk5PsettXIB6HovpUAqkF?=
 =?us-ascii?Q?72myTeElfQYyMNuF8Nup4hXmtlIQd+vkDiG15E22d3dc6uGvXMLKbkskh8nb?=
 =?us-ascii?Q?HWZtQWG4UjRITnTGcmQJ5JgalylZt+hOZ4FtQAXSbHUj8A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eb3cf05-5f84-4e15-c837-08d8ff4520fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2021 12:59:24.2036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F3waHhWlcGjxPZqP59zrSaCct6DAsa9Brzz5UgzK9AS8WmXJxxPP+RiE7jL9ZfljQjkBkwnsUJ1lro5Wyh5KJljvprMIL5STXTNrvZQxmIU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7477
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 14/04/2021 13:23, Johannes Thumshirn wrote:=0A=
> From how I understand the code, yes. It's a quick test, so let's just do =
it=0A=
> and see what breaks.=0A=
> =0A=
> I'd prefer to just drop the ->ro check, it's less special casing for zone=
d=0A=
> btrfs that we have to keep in mind when changing things.=0A=
=0A=
OK, no this doesn't work, because btrfs_start_trans_remove_block_group() ha=
s=0A=
this ASSERT(em && em->start =3D=3D chunk_offset);, but btrfs_remove_block_g=
roup()=0A=
from relocation has already called remove_extent_mapping().=0A=
=0A=
