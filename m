Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB698567EEC
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Jul 2022 08:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbiGFGtr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Jul 2022 02:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiGFGtq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Jul 2022 02:49:46 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845E514D0B
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Jul 2022 23:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657090185; x=1688626185;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=XSTMnHtlGlV3yxBm4oAxffhgqt8kZSylVkjiBHKL/Ox00uZv/rI4dBht
   qS4y4c0enMFHgEKvsCOWhJZ/xUwn9zfUIN5Yc82wRAtPtn82k/Y+BDXpo
   K881zxxNoRa0iuvY1cKzTVhfn9zBEEVOImFuD0fQAF1Ws51vfyuYJLTQG
   e9Uy/pdq9vq6zxWov8Dy5nDEQUSZU3lZLHA9jivXQm3v6Fj5CWnJtkd8Q
   NqtXkJal4qeJCIEKs/mWISNb7Lk2bd0rUCm6MO+LeJiaSBtKz+oi8j+v+
   vVXo6yyHYbQrdAjXcHHWve/bsHJWArbIpkfyr0RF9Rv7Tv7fUfkpGPNU5
   w==;
X-IronPort-AV: E=Sophos;i="5.92,249,1650902400"; 
   d="scan'208";a="205665680"
Received: from mail-dm6nam11lp2170.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.170])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jul 2022 14:49:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Em33v863lPs3o/U3pcIjh4P0pHHIpRtEfEdiepVwQSEZ3wIGYOEAsSDF91M4oAMRwcZPryVyNcAmmAIQwxhEzYgFiYU62RzMt6DM8koII/eHUdDVsMfr2cz/74sPjaKJsjUO/O074PdtF2rDOd8y6osZR39PYNhjWo1YcjqMEc79POWNJftSSR/dHFgWejoNw37HqSphwKcUoW2ubRksiUs3LR8nc7iLovqyFbt+j/sGDUTAmqt7pf+a61delEs/2wKxhBlpAlo/Yd7T17I8qqAzImcx4YLUqELHCfIIPMCSqJ6PhPxD6UrE4180zIshhPW+LACnGYpiaOhyWTblZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=bTy31yMthg4jxU2wX6Wl9V8g8W8vdObuwkcXNEqUJCvrOKve4orxnSR3usJXRVgoPcTRFVKv5iI7F9Mtj/3yB7KWVTZ5fx508+va7bs6vdNFMGyKYu+1YsGsbKnD5/kTyi9ER9F+6qzGidYCgpCN+t7kqmyse5ax7cBMlGzdas0ScbpO9e4a6qhMk906ynql5LnObyvsvCGRPEnT7O3EqK3/4rljqVOg5p5r9YdHWwpwDaw2xa6XURDnLF3TVH5faBQkqdT70yrfBxy7fTktSOA0tJ32SZCeEqFv0TMR+9fa+gf1/m6H63KqN2OgqvIKxpvP1w7/5BR8so7uone7OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=rK/FCzG6nimHKNW1GYs9mICUkFyAMgy661RIFWSYo4S2KhxnmvXAe4xgWs0Gk0HSSzkOqg5c0wrDd1rPX/24VRjINZSOv76O4Ml56jglHeBYh6ScjK0ik8z+uzhGJKD8GvuQ8zFY4/+IFD5hu6qVC2H9gwEwwZjgO5mZePkgWCI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL3PR04MB7964.namprd04.prod.outlook.com (2603:10b6:208:343::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 6 Jul
 2022 06:49:42 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91%7]) with mapi id 15.20.5395.021; Wed, 6 Jul 2022
 06:49:42 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 6/7] btrfs: split out the end_io handler for cloned bios
Thread-Topic: [PATCH 6/7] btrfs: split out the end_io handler for cloned bios
Thread-Index: AQHYj4JLXa+OYq2CC06yxHvP4qU02g==
Date:   Wed, 6 Jul 2022 06:49:42 +0000
Message-ID: <PH0PR04MB7416798AD8BA5D6503554FE79B809@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220704084406.106929-1-hch@lst.de>
 <20220704084406.106929-7-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aeb2e483-8c46-4598-e260-08da5f1bb46e
x-ms-traffictypediagnostic: BL3PR04MB7964:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eSc56j14Oe2r+EpvHJ1QdoEpFxtP4gJM0EOHOpT+M4PJw+I89/gwDvfljmG4YcaBpUEixilCDdkcImad0dNluWBJSd8mfMRVffbgrTKbLHotuX6brmywxePsml/7ffJGOohB5CIpIPK6Q+oQxV0eEhf31ecMwiRkQljb6WTm+KsGtN3Pc7V7ruLNeMowXw5GgWawEvQ3capSuvvD6f9mvtmOBqsPeZix118E45Z34GJARwge+YZqmBDrXaN/ZtwqLL9uAB9mF3kI3k+lNiCZeaeqUZK0lX/ssce1rD9q4JWelQDHDu91lEiZN7nYHmCyvoBXQqkArIDDQKpUkT2Cc2utJdK7nVP13v37LAqpKuPZpkh5tgVtqH5B3vz+hzDe0IwQpGrmVBJiresvDHTilD+NKbTfwJWEWVToFrANhSUaDErh30rrtJqBZugRc7yPKSKJh/d3LEjn84NrHvWTelYYVhxOpKywUy0mndH9m/ODTCZPy/ccdAyiFA/uYGzfNJqk4o2ciBHlEAvWMtp9OUtMAUdLtV6T+lksx74nJvGFa3h+DJMc8yRY7blBjJuVwfuSFbqEGGEQ8rd4+mCcuXT3x5qiPGP4sQTaX+FntRVXQWjVyInI9PyHxenWiTpiGHw09U16Qyfnnxc5wsM0DEJ1EgOSAigcp7eOg1ByNRnafb8+Ziv7yixyibs52mct1tecDWTSzuBC/HJqCWxaSYn+S4TUxKQ8CBTHFhOMORCOWQSLyIVe6ZXGiLtA5VeA1UDq3aEd21r9f7FJ+IvyS6oNdAMR/Hjk7tjumy92AVXTIJLIWPOED77mOEsq32aX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(136003)(396003)(366004)(376002)(186003)(71200400001)(4270600006)(55016003)(91956017)(26005)(19618925003)(6506007)(41300700001)(2906002)(38070700005)(110136005)(316002)(7696005)(122000001)(38100700002)(52536014)(8936002)(558084003)(82960400001)(5660300002)(86362001)(66556008)(33656002)(478600001)(66946007)(4326008)(8676002)(9686003)(64756008)(66446008)(66476007)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KAKNKk3AyIA7PbS/LSS4Da1dJ4b5M2T2Mf5mctZS/oF91J3/NI8b/VnjxEk3?=
 =?us-ascii?Q?vwuI68lfcTJTEKfalWnOt+L6wKGlgogjAKuj+5k9shyT0WGDMkeAlQ2p/cOB?=
 =?us-ascii?Q?TaSNEZ3Wtxag297XNYI4W9q132K42ENFyxYryaIhpXSDJBcJ7EwQBLawFyOn?=
 =?us-ascii?Q?vCqUj77YnytEUbb/OdiN5b4DN5wTy/u8ZchwUCXC21bRg4OFl3DtDoJBboaU?=
 =?us-ascii?Q?hSQZo/NkQgQlTroJpDTOHkmsoDjsmhPpUVCRCS/GyE5cpdbfvcLc6VCZOm8D?=
 =?us-ascii?Q?OvU9ItbO7DpU44tNE2C2BDFGMBxSrqF3D50bPvm8NbFL7kSfZQah9n+xKi/v?=
 =?us-ascii?Q?3q/XpiJtCVdQpam2o5FnMB0mMxJMpObrPiWIt4mOdrlN0SJ/j9Wl6zhjaslQ?=
 =?us-ascii?Q?QZe+gq1cF7XDAAhT5zfKlBvnXA+NBATosqRpJhQIZApR292ptYfHvmX0JJSZ?=
 =?us-ascii?Q?mMQoiXx1p5j4LQwkd+Ph1ESsR7G9J/uNg9KXcnmro09aS8S7QfJ2TC1ZzVJn?=
 =?us-ascii?Q?WfVnF7Ss7iPqWvnFPRK87DI/n2AD6rJZd2AQ4nTCsbiwDWvuiThbZ0upq2mN?=
 =?us-ascii?Q?Ps/bvqK8BsxQWg6b3EOg9BJCRVQhLOw1a1n4hyflpe4XKAKXaVQIWYMx3UxY?=
 =?us-ascii?Q?kDDXgUZoQg0gKbUaZwDb/5fkp1M/3NV/riFPloSSv7QSr9Y4wq2fQvXIwWns?=
 =?us-ascii?Q?k168Xtzc/G0M6KjYagcYmtJWkUAQzyq2r6Twic4+VzIcJCy7Mr4Wdll4bf08?=
 =?us-ascii?Q?Drk3DLByeURdYC4VxggdyAJegY50dmKbELfYRKdG6h90fYXQqwid0oSEchq6?=
 =?us-ascii?Q?szzGpKo2gdDJf2ju/HjKUfW7z/46qnCSw3wtpcdY+Jylw3pgGpDP9NPLZejI?=
 =?us-ascii?Q?JpC3dAesVMR/kJRhrziPj/MpxKsG3SFige2YsvdkP+5NCIlYYR3XDz3qmIr6?=
 =?us-ascii?Q?LrcG5/krheB8lnjZZ2KzdCMPGqWe+eeA7o1jhEtnZC8qViJ3v3aFimcZcDp4?=
 =?us-ascii?Q?MzaPwHPVHt51Xg7stBa5S6/9DiiM1eTTirChnUHd/iDtmGi82eUZYq+RJo2V?=
 =?us-ascii?Q?VOhCZwKsPBAqOOmd3TqsmliOzxuosFkkFcFA1Hyn9TCms2r8PR/iKtWuBIEi?=
 =?us-ascii?Q?Tqp0WY4d11mVx48yVhE7wiwG3gcfaxgcBb0orZiQS3qXRNPPqnYr5u5d1ruv?=
 =?us-ascii?Q?WgcSdbLWrup1wzdxWZS4vSfBwab8FeWt/lUzwsplKvoVGkyLYptWEKlFnxGN?=
 =?us-ascii?Q?MU28MQnU/X7sBec5kJR/vynweN1GEpDnw18bw0+wyiSprZOIqvCNFVIgyIl6?=
 =?us-ascii?Q?z/BB9WeWfz2AyTBzF4DU740X7lquM93Mwt5tpOnNg/kiZK0adlcB2SpMrnu5?=
 =?us-ascii?Q?pPDh+7SMHhqj7S/n7aUp9OAOKbL7d9Xli7BnZ84eo9WPu8JtCfzicLiHsTlB?=
 =?us-ascii?Q?KxE6MyuVmLISgSKX8f2MQLpx81Ssj2u12hoLW354g1ClqwF55e8WmM07RuLW?=
 =?us-ascii?Q?A8JejY6MF4pB6KcxOB+TSmmEdfxkZgN91c9waTCKqCYiLWjoARw2XlKlIWuw?=
 =?us-ascii?Q?S+NjFgqc0RLkzFV1CglQjUHZYptCMM0mRvd3A/27Uuy5VjU0keQcOR++r9G8?=
 =?us-ascii?Q?0A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeb2e483-8c46-4598-e260-08da5f1bb46e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2022 06:49:42.1799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AhgpFKgq6KBuu7CxYbNkK5LyVlfcOwrHhxsfKdoKypL9/EjEMm0qFpb11YDbizhTWCfaCoEx3aOi1UndH6HB4VpueyZt9NyRtzMGDfBgwm4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB7964
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
