Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76CA5525DFD
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 May 2022 11:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378508AbiEMIpj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 May 2022 04:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378524AbiEMIpf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 May 2022 04:45:35 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D852AC0CC
        for <linux-btrfs@vger.kernel.org>; Fri, 13 May 2022 01:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652431533; x=1683967533;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=QEfTJbdLmtT63U4mTUOgxghKO3ayd9EMD5DJ0ePln8shbiJECmI85IDo
   4dpturSwj/aLGbINu1FyCPCwTk458qb6FIDwo8HxeyMltQ3SjC4HE68dL
   +gt2EAmNpswgZq66Yx15GBOFE84IdtQvhBroLSmo/i1HV6j4S4NspGv8Z
   Rj/2TBNHry17VhLlsfKtqae5r9yKcf2zv79ZSkUWiVWzQCvpv6+t0u04G
   vmcVyQ1Xk1GQ2Rxvrt9nhI32PBfMJ62LlidcR8dw/0B2E+d7uNMivHzJN
   129sfDphtEL/B+rNqBdXKCZ/a9o5UuTNdwktWHX6kCA1lJP1QKvUOv5lB
   g==;
X-IronPort-AV: E=Sophos;i="5.91,221,1647273600"; 
   d="scan'208";a="200253249"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
  by ob1.hgst.iphmx.com with ESMTP; 13 May 2022 16:45:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P2dJGh6WB+Wu+94SVGCEJcllVwGnsCm6YnJa9r1cBEfqcAg5n+qU9ogt+qtgvEcP2r+lK2ZCGKv4gvpFV7w39oMvTSarrFx7ZZfkSvybzsYAO0E8YFcY04zUBlplbAQ17DLcyGrBP+a6n5zeM7skyZVuYoqN5DzIUPP9J2h5lt6nQMMY+GX4tcKKWCQ6USCsNOhztwH0Kvd5TC8lH+t4qmVdXpdPSthITVG+2kZc6I8br8gQJmrEegJ2WSIQnkWmxa7/6xIdM0QX43dTTqtfc6hdAUjXP7rf6oZHpPQowS5RGvS6mIkJmd08d5/A9zfXTFSv+1xf4tzQvTg70V8Wgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=QBFKErZ560dHK2I9f247NLNh+j33+v8Tu8MPMWuTP/Ybb4LJ+gIdOCyPvWY9duO4uFbBoIzjUjNRWiz3WXDHcQniob/S0HQC57vfk4HRc6ZWIpA28uVY2f2wKMGbdINmCuIdCNgCXYVUJdI6Uk5QnZuu+5gt8Bba8KNkICOkpVecXKdMZkcrw/5TQi5fkBC59IqRRt7nkcIy79l59zNrU5FcqXIPEimiQAigGWRbW3c11reyQc729WfAw880CX6ZMiyFmsqWmZGZu+eBfix/ATTRLXtj8XLTeSqcHqbOw0C6gZFx6KKr8DwRLrD5jUbkPjFH2FcWeAAb5mMdDqgw+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=lczBgyqXTa+FZSpbOyro8/hg/2C4mo4K8BDBUKjDrEdmFZUUJt/k6Vmw3yj0HQYEkSX8y9kca6skUi2KvzqIfdtMrQA8Pz74QCq9SXpo9gijHn6A1Ygj+mJQOC3w0PTarNxObYXG+VNvmbE3hIY4WD1mrvDNXVKvmPGjr7P0TDI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH2PR04MB6743.namprd04.prod.outlook.com (2603:10b6:610:9f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Fri, 13 May
 2022 08:45:31 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12%3]) with mapi id 15.20.5250.015; Fri, 13 May 2022
 08:45:31 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 2/4] btrfs: use btrfs_chunk_max_errors() to replace weird
 tolerance calculation
Thread-Topic: [PATCH 2/4] btrfs: use btrfs_chunk_max_errors() to replace weird
 tolerance calculation
Thread-Index: AQHYZqROQ+ESzQDm2Em3+9elMzAY9g==
Date:   Fri, 13 May 2022 08:45:31 +0000
Message-ID: <PH0PR04MB7416F6F5FAAE38CD1F1F15559BCA9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1652428644.git.wqu@suse.com>
 <b10b56b94a518bb423b89e29c82639584b68eb64.1652428644.git.wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c03358bf-8f80-44db-bc64-08da34bcf022
x-ms-traffictypediagnostic: CH2PR04MB6743:EE_
x-microsoft-antispam-prvs: <CH2PR04MB674396DFF17DFB3ADE1510E39BCA9@CH2PR04MB6743.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UYmGg0SA9i/Ju/pvnDoL4OZulfqvSMYW9MBxGZs9++J+Jki6y1k+oVkT9x5hB16rQ1mhUtjMu7eVgXIpXonBagx7R17783oshD0zptVwcR3vIlskFW9bFXGzIbhP8YI8o/YF9pE/ujhaHvtICWq0GrfLX4xfpgORRKJMyGsExEoHLmGzoFM8ZWdESGsCOyVNU0mmmplA2Y8EZy4d0Pb9Pd0R3QmG6tcgPwEsLjib3m45k3Udwp5otWpvOChUX4OQBv3wAtaOLmyJR/dmYilq/2DbyMK1RIxqLVikeOFeGVkOEATZm2o9TVVRN3BzMRuxyulrBybwjgdoL48hN+y6IvQoamOAMNWlQRDq+kBfuNIczdJeuCdMam++sxOyYUpBkohzzqv9zK/YSleaFZSZUq0UnZuMtwwO3J/6c2GMRE1CbQE9HMmZCLKP5mDWb8ebDIwr9B0UcM0GJ1P1fF9X7//dI0wHU00cC7RHn/v1BEpUZn8cdTXRbhVNdSVefFkp1xwBcY6BOeUw0/9RyRmeaoWkBj/qg8z8DmAlSPM6KCp051i6lKAT+s+2HuRmsFafhale6nNRhTzYj/87N43m7GoQFc2YDwB5sfQlodmZPixoUOkTQ37RChDkaFwogga6MwMSgNg1zheszKRXioEL0VPJhljXBH1kYTBxcexiRIUIYGfB58sOSSS7MrgWxLTU8GqQ8nz/ayXTJesIDuuPjw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(76116006)(86362001)(8676002)(110136005)(316002)(91956017)(66446008)(64756008)(38070700005)(66556008)(66476007)(66946007)(508600001)(82960400001)(71200400001)(122000001)(38100700002)(186003)(33656002)(9686003)(7696005)(6506007)(26005)(4270600006)(19618925003)(52536014)(55016003)(558084003)(5660300002)(8936002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dvhdLLGot7H8pXHtjST5d8PNJu8pR+mWj7QlQUh1vTukCh2PsaJUWvu62o69?=
 =?us-ascii?Q?nNhg9tpZ4MyfjxbE383ejdSBa8bGCYYI8kpWQWEXNJKYxyr29ASW8JT1T0BZ?=
 =?us-ascii?Q?Ew9+kE7UewSIu8EdygIkYl8q1kVBP0K4oSLpGzXl8mIvruXxhtrjcvQmFkMB?=
 =?us-ascii?Q?vmBeQEpbueM1mh/YqlkN7UwHpKws9R4MM3ixTTvEUhfuB11bFRHlIArt7s/H?=
 =?us-ascii?Q?VI1F0RIQDHwRr5hxw+qLzerAw3mC2vSaOivNpZ0cuIhCo3eyeAEo/UTI3G6M?=
 =?us-ascii?Q?8hv4dh91QDevFq8Lo1UrQdlz6dyjSKMKPD8l6357pDX+ngCog8zstTZCyQ2+?=
 =?us-ascii?Q?30rl2wrVSQFxp7a9aqs0ObgWI2p+6IO/VCUwVFaXmkQuZA3nDvh2YHtgSgZb?=
 =?us-ascii?Q?rd50e47n6tE1DkqbBYV9P1I5mFeKV+ByHuVTEoTg7v1bZNzoLK9FYAVDdNZe?=
 =?us-ascii?Q?bNCCQWHo8Ay08X6Hqy2AItJXmPkDO3AdcPs0VhadeGQ/kXd0ldKh4T8fJP6G?=
 =?us-ascii?Q?LlSoPyWDuF8mjEukPghDGQcrNW8+i9f33254oDa9U3dYAaEPXnkUHlOIYNbK?=
 =?us-ascii?Q?1UbTkYbiQ+/aTGBucilqtPhnuhZPJaF0UtpBYOGlTFyt4egNTA7vaW8eXtxc?=
 =?us-ascii?Q?2C2KlNIvEGZJJQo85AZ1eGTjxBJBlgz8UFknDiqNH+//1DZnZ5CKYegrj+LQ?=
 =?us-ascii?Q?LD5dpi4dgR0OfQvWP7eAsGKWyxcry3spGB5e76e4UU3YuZtQWowiD6kadSM1?=
 =?us-ascii?Q?YJeyu3/pFSYlazNGwcZGi1+bQCj1c8IWCX01DlRarK2UdArpjIr+e+7U9kCf?=
 =?us-ascii?Q?2fAYe3C9acM9/pd1/zk08DTcRmqjLay1wScRqKGTR6OZQkzOmqSgwx9ziwvx?=
 =?us-ascii?Q?IAE9YiNeE4upEvYh+EuivmLabJihfhUJZFkTpV4PsKpV8HqXkGC2E02e3tLo?=
 =?us-ascii?Q?4keOZ05F6YfmDunUldn1s35lY9rHGK42S2w4SbUjw3QlxQp/ECIENoqZ6DvU?=
 =?us-ascii?Q?ZktBtd5cV5trszlF/8Lpo47+BUhe/rar+cBd5JOkUSQwUf/6YRSp/ppXATEv?=
 =?us-ascii?Q?1Dm00NCyF6JWxM0GK1nD2jn7+wZgEsJm4Gj/vv7DGWjtoRQUS30EB0UNR09R?=
 =?us-ascii?Q?JDK387LYQjbLts+EBxPbkx9whatQtZK1qV5P5Qes4hvxTe8kI8lMirlqA26G?=
 =?us-ascii?Q?CDS7jtI6sWuTxPmrMkIEyS4sHcOwqcgHJ4b+qSlkfkd3HevkyPmY6d8Z4cDo?=
 =?us-ascii?Q?s6U/uIaPk34JupdSqR/+NNYAQLgYePuYfof/pUSl+PfixcE2Q1v0yZI3riGy?=
 =?us-ascii?Q?JSyHXRigDh5LyVZJvLOuYLDyb0NmLdVU/CgEL405DRTlel1i6Smc8qoQNwIj?=
 =?us-ascii?Q?dkDgKPtf8vK+kN9nZJLxAMjc2Kia8bzma0B99uNlphV4GLvujhXVBuxqUiuM?=
 =?us-ascii?Q?HHUBtwW4AzbOSwTT2Nz8YIj6joxWxVngBi5y/VsbRYbsTCQPn8Zr6aJoEs/n?=
 =?us-ascii?Q?olqwoiXbJ7bH8xHshxBxrN3Wtj9rvZnLo9CY0OnEtQ0Zmj+cFXldgrbOpzml?=
 =?us-ascii?Q?703MVND7Jb3+1enx8UjecIa93F0xdQwjcmo+isO4njt6h/U0RPLUid/5+53M?=
 =?us-ascii?Q?2RDiP3uPrDj4+reVTndvlYA3D5RcvLdDVfRL/1TsTWu3WDNft0hZpTTnJYib?=
 =?us-ascii?Q?LgKsEUbtOQ4pW5To139RDBA8Of+LiGKEWQcbADZCes7wWtSFfWKO+IKzEJYD?=
 =?us-ascii?Q?KQZmZsmoVlhr560uRMTpc/YypMA4Zz0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c03358bf-8f80-44db-bc64-08da34bcf022
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2022 08:45:31.3182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JKpfJCb4qxI1LOA/bUzMclEmi9mppRurMD4yMG7vyZOf1SuOCJkOm4VRjG7Lrm5LtmP8wcfKpF2PqNuDGOXYvrX1UY0+QjHFkBkQ38fLZZo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6743
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
