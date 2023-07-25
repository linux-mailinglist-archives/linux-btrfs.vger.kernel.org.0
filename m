Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA255760DF9
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jul 2023 11:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbjGYJHb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Jul 2023 05:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbjGYJH0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Jul 2023 05:07:26 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB5D121
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jul 2023 02:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1690276044; x=1721812044;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Ugwlxrp7lKGTkHJOoOSKYNtnM4E+WQjwBoTTITsiczQ=;
  b=QF1Wt35DA8f5/5/LDdFFxxTUGdjkdS3B2cAL3clIVlJ7SGrssoE0WBpj
   EQi45QJTjKZEl3hq65E7vvvGGmJ35eeuKzb6sVehv2YQr5abZzFpnQQDi
   ZTsBrlJ1I+HMeXLljZshgAstGoo1boW2Iu29HR5+xTU1NxKqPIBCJeyUY
   ss54vaIZDRU4BdCoEaajE1DlzNFJnu6f/yfjjXG34yFJvAzNJpA+pNsKt
   whvcpX04DkCjGMNWhkMxk3xQvygzTa1MsohLWzoJ3INXkpa7Pe0oGypBH
   pWLZOvGAa9CIGSnFtlpG4REWibFq+1V1npok6UW3L21wzWuK8XIWyQctG
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,230,1684771200"; 
   d="scan'208";a="237355551"
Received: from mail-bn8nam04lp2046.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.46])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jul 2023 17:07:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JyrgS6mMzQZbwJo2fUYBncwb3E8Fl1EBGavQdFN4hg/zq5Cyj40+GsxXhiEGpJ5Y5cdwjwrAlq6sCB6aWDOhs1X7OAxZhUp1dLhn0Km8FcRKBEzl3ihU0+fgSRI7u0cgx0Q9tKKcYmRdYHJkti3ZQAzS4PTTJs+fCzyIIhrf2u6RfbHPnsuZMN9HSuOYrcMvbyxyDlQvbSO7iT7gqYN7w3oQCvNfRS/H8VJg50s47wgOdpgnb9N6/xIQaWUJT8gUItUBxJKn6IGdQ/DQaMO2aggrg0uDShfJZGK2/blRxF1oihtpWbMSAb/cZfid0626qNp+/eq0yxmKevxZDBqLPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rZmaM7pFIkXsEeYPZULqZaVpTcLizqXLkfCQpUkON/o=;
 b=BblnScDy4k6/Fmg4NwPHpLHMomdnLo2ZO1O8lI/7kFz16rGLNSox13kHVl5jTHIrFIQ1+AmbYHtYRJ3GjvzUNytk7ZPeEYTPpQoRR12K2+CAIzUEWBSAE/yjy3/E3DImENmcdAjEJqLcmuTHgNBGEMEU9bfJist6QYL3ecHrq0WmbUf+i9Bg+cMtMXsSrSl84+I+Rav60uB1VTzk11wVPGOBN81klYfaaBPJTgXEPHRTWt0OtCg2NGdqBjZzmkHWEWGyeF+yRulX7BXFOoETRJLL2oObsWysynQC2KqHOlA5zLKb5uqJ5bF8idSBYoA+0MdTlwXJUxkQAgR/Y0EJpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZmaM7pFIkXsEeYPZULqZaVpTcLizqXLkfCQpUkON/o=;
 b=CFgta/Pz4k2tCHa7PsmTb/iUsncG2ke430W/mQKFUpL+IUMM09Xy9idDB0B9Mzpu+AekeFevDtezmJYAeXOuGzx9l7ZEZOgm3deBRWkOGdR5Wik0RslYDLQTeUYJvSr1Ol9a6QEXCIhnY0LKfQF9yxEBpJjCTljOtNU1Woxeodg=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SA2PR04MB7692.namprd04.prod.outlook.com (2603:10b6:806:137::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 09:07:20 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::95cf:429a:bc0:991]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::95cf:429a:bc0:991%5]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 09:07:20 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 4/8] btrfs: zoned: reserve zones for an active
 metadata/system block group
Thread-Topic: [PATCH 4/8] btrfs: zoned: reserve zones for an active
 metadata/system block group
Thread-Index: AQHZveX+cJaD1ijw0EKDmTqVKBD55a/JBSUAgAEt44A=
Date:   Tue, 25 Jul 2023 09:07:19 +0000
Message-ID: <xv2bbg3ae72huutwcrk3vsuh6tsfajlkfmsg64w6rqa4xkie7e@jdv7rtmw6p7v>
References: <cover.1690171333.git.naohiro.aota@wdc.com>
 <df9fa11d7d8299b04b99d7276a764bfa318f5734.1690171333.git.naohiro.aota@wdc.com>
 <ZL6TioS4YxPUJEdg@infradead.org>
In-Reply-To: <ZL6TioS4YxPUJEdg@infradead.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|SA2PR04MB7692:EE_
x-ms-office365-filtering-correlation-id: 13459909-f984-4265-7565-08db8cee8d17
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uvwkJtxifxBWDDLrWoJ5+vi3bRIJpCEhrV8SCdLQehJuAYMjpsbxIZnpRZFHGru2OSvvG4qKxqysvcnEqX9vPbkkexXTRMcaTcVEQ1cmWNduglcJCNmrxFVvw1B24G0I3xgcdFXBcGwGKsgLLPUcI1wLhBbn9NjS2sd1bfzY0gt5P+aF/zMKvJomA0k2WYgwi73njrSXu1CiY+GqI0DOMrq2fSyXaVQLuJ69luiOybTRa4FQYtEGn0YV6joIyIymNUM3XOQz/jXfx0PWqsf5Ufw15GHf4Md/cOjUo86r0+qn8GCCOzBjhx2AtllHVgf8DVtuTaOlYRACizKUKAw7jTmN60NqevKASsFI/8snIlbDwU3NZyg/ubiqE7NUp9pqCTBozjR2dKP+oB9a2vR4bquXvifGKO5/wIXrlqa6QNym5sHiN+K84tKbMwEtxcxFMYcGbqwOzb6O2dPxkb049cx9T9tKuI87Sci6/29TUF0l8Ncw6W0AwLmQ5XuhKaZA+RhbPKCpCf19zX1dK4kls0f8l7uwCB9PfrJXoKFu8pmIWPxbtsCzTg/PW5wtiRmTEjIie0WO++7BwTTsW/O7LNF8QPcEELZBiYKKvDF/RZU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(376002)(39860400002)(346002)(366004)(136003)(396003)(451199021)(26005)(186003)(41300700001)(122000001)(6506007)(478600001)(9686003)(91956017)(66556008)(64756008)(86362001)(33716001)(66446008)(71200400001)(76116006)(66946007)(38070700005)(4326008)(316002)(66476007)(6916009)(82960400001)(6512007)(38100700002)(6486002)(5660300002)(8676002)(2906002)(8936002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?u9qtF+zc1ZVSkzVbx4ihWomiZrLeGgMHKeUwp02Rs2q+hqAn4d+hDAWVC6qT?=
 =?us-ascii?Q?P3abyD/THTGFnhsBEIyubdmqI4I/dhfAQXm338W/XZzY4A62zB+KwDKstzBo?=
 =?us-ascii?Q?1C6bMXeyp+ue7QrhdGEiexkSkWoyb4yEHuY+jKJT2ut6epsbgbuUs0OfFeH4?=
 =?us-ascii?Q?qg1BXklWOtdUGtcTK6e3jyKUCgtxL8GG4ex3AoxzimPVXfMSjgKwhRaI253b?=
 =?us-ascii?Q?fkCsSmQaiqOe2/Te5zmtZ1ruXupjmCZb6376JXNOnC0ztn1XqdjTV03Tjbzj?=
 =?us-ascii?Q?TDVu8o7iPY0Ru3hW709MEgLdEYgfP2IrlO0GtLOAKwtdVCptdIT7V5oEtRNC?=
 =?us-ascii?Q?p9eArKlzMtFLH0NXsVhdSYmof7ji36efv6oisiE8XtV7i4noRZ3gOO0REddz?=
 =?us-ascii?Q?4cZEq789fH9uThM7epdGd+nejH//J+TQ7rZ2p8+uSL/QMBWrxIWXisHiolHy?=
 =?us-ascii?Q?JIUGbv842XwNRO9f7k4cVEV0Ck+mUHUJGe802UhqXN8/84v/kM4mOJZuQX5I?=
 =?us-ascii?Q?UyycaplBfz+pfm90nYC59kfEBIOUuwDW10a7YJnajgfWu+AUH7yHe91gEx6x?=
 =?us-ascii?Q?DlNljzoyl9lTGuD4TIqD+MnZXC3GFCh/K5BaKWvjuuajAyIKQEkT9oBYjyi6?=
 =?us-ascii?Q?qdVytBle5T1q181yPdDqu4WvxmKofI5nRpwRAamLRBgXjDRhaNYZZMip2V6m?=
 =?us-ascii?Q?Vek5Bn9ZjB9ajBYoY6Kca0iIDljhHQy0d6IbwzbQGfxcqxxS7vjWgr/VtWd1?=
 =?us-ascii?Q?UyCIYaJCZmMFsOg6gmlpwbIqtKX/ITh10kurefPiJV5vt5pinIL82HA04y7n?=
 =?us-ascii?Q?lsDJ0oQrzwFeggPX5uK5VF8jMXmNMKsh4yHW5CAJBH+muf/C5+KYS4Nja3M0?=
 =?us-ascii?Q?RNlT/344gXdz1olq7XseHft9w9ThRwSWuHQi7zE+mB5cpMINj/j4c6hPne7s?=
 =?us-ascii?Q?hIqJfshiuo949h3UPZJesjU05odxudFG8qn4+irBxq7esq3eAw8gywAYIuOa?=
 =?us-ascii?Q?JmljH1jqiJXSe+MVv3kjZffBLfqlVBybI2A8rGDfSS5UmYeJikgvHEXJ7v4O?=
 =?us-ascii?Q?GeSISJ4McR0r5TD6tOEntoJyipCqpJz98+9XsHC9oDQbXswEa4TGmcIEM0VV?=
 =?us-ascii?Q?GyPEI9L+GJQZA2c543sU8pvPR8SuN6+X38E4IeOOBF3iEY7MR3gMy4NNndhx?=
 =?us-ascii?Q?VzMxiuBw/truPsUTDBOuwIlXmEolULBuNNb0lAz7w9ZGfEEB8+jGJwc2uRwX?=
 =?us-ascii?Q?FXRZ1WBegIPVV8eHbCShW+U/RCSsT5eZQEorNjl10l0stJk0vmhNgRk17rMD?=
 =?us-ascii?Q?aQslup4jy/gBs1yfqpJXboG5cbR+5oCKtTgjOcwfCIcoLvgxCkPTU8wDEckX?=
 =?us-ascii?Q?p2nLg0YxC45MhM4VF1/SotaTW4VHjWI7dxnvxljj72Bmz+1dJcfvKl5OPpCK?=
 =?us-ascii?Q?9HjGt5Ac8CQALUE6uVMY3Qox4vHi693LHm9uhjqPeydyKO35aAxL9nKQSIWt?=
 =?us-ascii?Q?VFNj7zVz1KyH2z4nFPBuDPMWV3D7LupA7Cjg3g/N9GiGU9HENqr6zohayG4Q?=
 =?us-ascii?Q?GJmn8EkCs0ypGGeUeQCAC3rfxzXdHUn1ByjCxDVlIvDj32UcUHQX43Xdx9Rv?=
 =?us-ascii?Q?/Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <493851869837BD4686D65F6BB5EEEE3C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uY07WMwoOo08xiLEup2AJDHHBUxcs01mbII/OQXiRAuhP6nbVpppOMzEeACULaYn0LsDN0fhBtzGLfARFjBa+8r2PiWvCnTBm7R2MrKL4rg0j1C9J90+B77UgtJYMJxZ8RrhJxHtH/e0QORBdI3X3sdP7bNHdnTD8++o9bm43droHPIh0uKwNwtQwd032iRlbtTIyY9rVJXhpG265GGHwK3ekosuQ577ymV6iy7ptPTCMJ40KlXT6ljhXXzqn38+sUx1H6P0+7rD8uKxSZ0Djfp2bS6yGYFpDzwDzco6BK4s/6MHeFZZbHtwOJjTEnCZH6DXmUlhqLcPuZE0b0mCCl6U2F5bhvoNUVgjOZ0SP6qv5rH3RYSU+wjgG0BlXffKo1ZQELfWNg6V3TFDeVEsultRxhala+x76GZVf/WEOnekF9uv9B1M5zs0CbyYJN5iRBv2nZcHiQy/6jp5Omu5k3GcpQJQD1cin33LLnhRAARgxAfp030wiMNI5pglxaJOjKUNVReTQ8egERvP/sFZUCZwEwlfRZ0Im/yZoJrtZlh24CZqDei+H0mwVipy58DyfbdXTphQrfR7rB858B8KArOzTIR2DbqseCOWLkqR/EQs+TuifIU0iYQUuUOvvTnIOTvB+tdQv2Ag7bYsOjGH6BBwCdMjYSrNj4rc7JCE6WD2ID2PFFEydD9+VUNU8CXtsW3RKTrvF8JpfBhJaHlA6UxPZ0EiuAzAmcA/NJoB2US6VnY3CsrBQtZXbPhIxDkI4/dEO9s7vq3hlEgPVhkOxgGP1j9QDtFX7ozRfM6cfSNCHthWCsPk29rWKDpoo/Vw
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13459909-f984-4265-7565-08db8cee8d17
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2023 09:07:19.9859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rnHpxxqEKmU2b07MwQm06tN32/HQu/b4a61M5ora8uDwsjtPgSMr3k3eqUsYqBqBESDg2azt9XDKU++yrChP5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7692
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 24, 2023 at 08:06:50AM -0700, Christoph Hellwig wrote:
> > +static int reserved_zones(struct btrfs_fs_info *fs_info)
> > +{
> > +	const u64 flags[] =3D {BTRFS_BLOCK_GROUP_METADATA, BTRFS_BLOCK_GROUP_=
SYSTEM};
> > +	int reserved =3D 0;
> > +	int i;
> > +
> > +	for (i =3D 0; i < ARRAY_SIZE(flags); i++) {
> > +		u64 profile =3D btrfs_get_alloc_profile(fs_info, flags[i]);
> > +
> > +		switch (profile) {
> > +		case 0: /* single */
> > +			reserved +=3D 1;
> > +			break;
> > +		case BTRFS_BLOCK_GROUP_DUP:
> > +			reserved +=3D 2;
> > +			break;
> > +		default:
> > +			ASSERT(0);
> > +			break;
> > +		}
> > +	}
> > +
> > +	return reserved;
> > +}
>=20
> Shouldn't we just store the number of reserved zones in fs_info instead
> of recalculating this over and over?
>=20

We can convert the profile from SINGLE to DUP while the FS is running. So,
simply storing it won't work.

But, we can hook the converting process and increase the reservation count
if it is converting to DUP? Then, we can calculate it on mount and record
it in fs_info.=
