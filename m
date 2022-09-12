Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46255B5D15
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Sep 2022 17:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbiILP1S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Sep 2022 11:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbiILP1Q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Sep 2022 11:27:16 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EF925C4A
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Sep 2022 08:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662996432; x=1694532432;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=m/8P46dFyT79UGNdrOzJDLc96tSDRvqL2vPJlC38Dmw=;
  b=O7aIjkF/69xXJAmV3XDVfJbkuNIKeFuV3LcTEDVpdBULgDSMY0R3Oepu
   pdvy7+5k6P9dgwDrUWp47+TXYnP3lTkqKD+y0T8qRSLw/M6aFD8a/DH5y
   eTTq5lq768nckbZ9ldq46N61XkBlWavFcDlOyv/j42tJpUEyPEw5Pe5SX
   BF50Yv1pN+++hUPLYA9UEqL/yYeIn6WGQUZOY1qdOpTs8uhzMKjq3st3o
   vSCJUFqkdF0Ou56BzX3fHAsiZralG5PKV3QPuX1pnTvMOmHgVocznxQEh
   MW1XDGf0g59LqT2iCbaJNYhFKEcsDvedILWvUf5Gvgej00IAhzQ2XtZ9A
   A==;
X-IronPort-AV: E=Sophos;i="5.93,310,1654531200"; 
   d="scan'208";a="211131205"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
  by ob1.hgst.iphmx.com with ESMTP; 12 Sep 2022 23:27:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMY30wQnsafYZBiF+F0frY0qS8AnYwYO9ecYY6pn2CA3IyThqxv+CPgxzCDsUUdr7nVwjHrLrmKbKEWNuvLMUjJB2T642ycBaMF+x6FR5dKy0WcokouFtM49uCtXOXMd1xxiPQH/nUe4UZREwHdgHZJrkMvZN0UdTqlZ4T0KvG/JPY8taAj4iJqe4nfnt1fYQHz0ukhFjn5wb9LNzM9NHypy9zet8EDK3AVOY8eOVDoiySEMo56W1bTnzbSMYnS4ZySqA7CvoClk05k/Qjrlcoc7GBjDMsWUcryAEcKh+aWi14lCnZEBbPfjHXo4VZLMHWWj9JThDoAsJaeEAKIZtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pe7YkAvcXwBcRvIQSBYdcw1MEL8iRDJpapCCpkGdkeM=;
 b=R3keJVP3/uSxQXd9yXybIMgmTtU0Yo7Nxf5H1cXGOQ1JCtTR74F1x7NzrE9jd33kfUB0RtuZ/ttW7/otAUPgclLynFC5REmzyresHjvosw/LDeJb+9VUpLvlSjJF3TKzHEEiVwqga/l/R7fZaKXPCqQVcOZTcKYnSuY1Ia4iGkNIoeRxIoarqAF/YzFQw/Vbqz4f1BmrOoZAfm2k1R0Geh4CE/MuMSjZu/kF9UTqhX0u37AadmT+tM5I4KwYUkZ8AQujd0AH3wxjNeaHkX9MftegNbrWCNMlzGB4AMLXsYOoamXTGr/NjG8zTi74TA1yr016UXmDiPRYM2UcGfVTOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pe7YkAvcXwBcRvIQSBYdcw1MEL8iRDJpapCCpkGdkeM=;
 b=icAz2vWgAewfLSXuFB8DkbkSGiI5l2RO8UPXrxXJYWDhAzv3xGmTUz5oeI7l4Ey6eDJFkw394FwcKVxlyYU0eKLTepjq0E5Lft98Fk9nP4SaqblnsyiFxkc2fwVdOpR/ddFoCsrcFDGmy81HLFFb/fDA+YXb1q4w/HV2RfSfuZs=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB5465.namprd04.prod.outlook.com (2603:10b6:5:10e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Mon, 12 Sep
 2022 15:27:10 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%8]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 15:27:10 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/2] btrfs: split the bio submission path into a separate
 file
Thread-Topic: [PATCH 1/2] btrfs: split the bio submission path into a separate
 file
Thread-Index: AQHYxrGZdX001Tsm8Ei4n6BvR0J2dw==
Date:   Mon, 12 Sep 2022 15:27:10 +0000
Message-ID: <PH0PR04MB7416C3ED5D9F5732E5C4D5D09B449@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220912141121.3744931-1-hch@lst.de>
 <20220912141121.3744931-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB5465:EE_
x-ms-office365-filtering-correlation-id: bf5bf322-7bf7-46fd-29d3-08da94d342d1
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nOAxBGMhg/edTN6hTDJDMndkd+Ww/wxDzuO7hyDS0LjpDrCr6WwFuRF+/dUZhQ+//S9IH6jPz0x00tu9ZDJh9KgPOYAnb8dp94AGkb0Uq9CF6cU1plo0BtdXu/En1ifQLybM1B6SRwQyXK2EFdsQGM6bj8Pq6X5h981FnBsdky3Aq8wc08zPi5+NExFpdmgbaANmuFYiYQRzdJ6LxMRoWkd9OPTQAcfCbongH8IkR/7XQZcwNLsu+vSTnMvmFsTeeGrvDw+BSaLHrKzRWv1Z7cCQnDVr8gxVt1PHD1oupd30baqVzdwLySNztHp4aas/NZUitg6wrTtG1XDHmmRJntoAtpSqm7IRKrgzEhODqbzOuiI3UD+zSSzgfzRS3tYiLsdx8HpgyDuEIWNuTtevkSITdmFSOuTwBvTtYq1Itz74cJ7o3qRxZbrpzDFFx3vcD7Qz4hqOTpkiyvyGKdMRFPCcaQ+f3DPue5WhAu7/J3X2KuYkMr/XmiRLXhJuGkvYIv2yON1kbYzK6CLLeyh5U56ut3WvuymOcKmuTqfo2ejAiKGnbAUS3ZaNAy9MBoSIod9GSbv/XbdcS97yHtCvYrHLSCIVvDdei5RqgEN33WTbuH9hSfWxecFrIEjz4jOoEAFY32sy87GDquY53qcqqmjreHnwIHHi+sKpSm7at+M0ZCECxnWX5Z0HanVwTE1mKyK+Opd7lgIypKe6De4QZknjNIqrv+HITjfhqLL/d2Ld00rs+06n/haD57uYvwehiatqxxsFVLCRTn9IxOAKNA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(376002)(366004)(136003)(346002)(33656002)(4744005)(122000001)(86362001)(38100700002)(82960400001)(55016003)(6506007)(66556008)(38070700005)(186003)(110136005)(54906003)(71200400001)(53546011)(4326008)(7696005)(9686003)(478600001)(2906002)(316002)(8936002)(52536014)(5660300002)(41300700001)(91956017)(8676002)(66446008)(76116006)(66946007)(64756008)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tzTcoS8hvXt18T2FY8QMRUrFnNIQ5xmM6XEvOph2xjqzewihrIn7nPhzu+YC?=
 =?us-ascii?Q?xmnVR//hpJBL9llF0gvqImyBgK3dAbkD6Y/Bi3PvCc+SZY6jNLSrlxNyuyjl?=
 =?us-ascii?Q?TchJtt6G0Zl5TDffV61VcupYjqNcMNmG75I0zjgd0ojEqbCG4sKdJRjgvO8Q?=
 =?us-ascii?Q?cmaaJCKHdWfvXyMjmMBTbVi82odiihHZSf1W//3a95RyPDVh+kj9iYI3fuAf?=
 =?us-ascii?Q?jUBP072zWNbMVc2+yYpsR+7gKhbGOTwvju0oOkhH+CrczzVmG8MQ1ExQ5SCv?=
 =?us-ascii?Q?vLSXkeCWyo+xhf5c4JWWnc4zI4nYymPfKWo4MlFLz4EiqDM6HNwUAZgszTX7?=
 =?us-ascii?Q?N2+FLMJsGWGU+zgCco/+sJWJrw3EPWX/mnqSbX1QShLjCGQ9JAiq09tDdGTC?=
 =?us-ascii?Q?wqkuE5tMkXODas867GwYIalrXQwEADDvKAL3itEd7pGh6ZivmuKaSq0+XHPY?=
 =?us-ascii?Q?LjbkbIYXNe862sSsY9E94IavfL1jEuE9V3lqsi/98VDNJAvuqX632QdShIos?=
 =?us-ascii?Q?tBsSri/wHjSt+c9IWLqUUNZL5xeA1kisDcWr6HJvGaYY6T4d13xuyg5BVixp?=
 =?us-ascii?Q?P9HdeIvltg8viqDVSADxyNFpDgpbdgXeWoCX9Nf0Eqr/FS0r3Lb1wRXI8bI1?=
 =?us-ascii?Q?SlMlG/+7mrbOHD8rNSMmrSr3e0bcEgvPFogVjFZJlCorSFGS7ZEvtCMEtc7i?=
 =?us-ascii?Q?979RRflBVaCiO2EZm5bK0vcxzf4z1mzeGdfZ+HgHIkbMn9uVLQMfvJACcPrb?=
 =?us-ascii?Q?/vRSXGSDqHnaw3B6qyd27hNbIeJDIxu5nLreslEfYwM7Hl1sL4cwl5nyzvXT?=
 =?us-ascii?Q?7kn/GceC924oczSeQYSflmzTfTpT0t7XA7jYqOYAdqrbcZtxaHxO3hwUs8wZ?=
 =?us-ascii?Q?ScLc9zIxbxsottLJRAGlxrvpPBxxCSyBGH51zt7RiqgguvMvm07MIQ1mC6pd?=
 =?us-ascii?Q?xIBDteSv41z8uU0SdoAQAmfBoitkXo4X30f13rsj/lSnZFkccHCIVWUFzO06?=
 =?us-ascii?Q?Si0u983Z9xwuaZnMmhpt4k0a/uvmIGFjHmzIWcCGZwFIhL3clXnps3FqJ40C?=
 =?us-ascii?Q?k2iMNBYPcAXwGouB5BKQp/PWLftWnBhHHfpjiiHWkDz2Q44fSFiyinpPhSo5?=
 =?us-ascii?Q?YTa58GriLhDmyI/R5LHwvPAhAy7CKh/Suxjt4nwtnjv7LwIpkXNbujqCYgel?=
 =?us-ascii?Q?j8IYIdxiDpO2b4mAzTJ+YrBYHMyTm9ZAeMp/mUpRCObh2GTEfHuX2dbmx9iu?=
 =?us-ascii?Q?WlneMrwmuOWsKOMZ/o7XOBolah857IJSAreurYrovIQSX9aAPEuSSZWJUn6E?=
 =?us-ascii?Q?CTNnDlqW3u+W6pIFKb5vKNnPl+U6AcR7ClinccuyH4z5YOHZfeCAzlED8Gzj?=
 =?us-ascii?Q?NUBYiyOvpTuxcbMFbpHqCZCYK3u+n+OzpDAPLqtTdsWQmTrvXMpl8VuM/7yq?=
 =?us-ascii?Q?OVJ9hyIihZvtD2piDHokqHQ/JKhFI3+PYDTE8hJejyqFs6+IWrUUtaCuUj/5?=
 =?us-ascii?Q?VEOxcxDZQXzjR7Xf9dgBHPBPBN7Xh1JSWhbJP1YTJD6qza0GpeD1NiFR3BaJ?=
 =?us-ascii?Q?4wmT60Cxeq9y9QoZ8wkHXdgG5be40tbCaJpgf8Z0EBET+KIOMGzHh7sRIqDt?=
 =?us-ascii?Q?8p3MIitb9V1CR/ATNxm8j898u9oHOqv2hE1k5tJdKU9EWxnGBiHvQ+bcm7ku?=
 =?us-ascii?Q?dEncPil01RiIbuGsgTwx7+0WAAo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf5bf322-7bf7-46fd-29d3-08da94d342d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2022 15:27:10.6048
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RNGYigd6izi9Pi0AV6wtwpXS31182UV/E/G6eaKA3c7vRh0Nky61EwVnd7qa7db7JsOBF6n20lQNyqknrq7QSo8lEldLipbyyqmzfpAFFqo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5465
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12.09.22 16:11, Christoph Hellwig wrote:=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
> +/*=0A=
> + * Copyright (C) 2007 Oracle.  All rights reserved.=0A=
> + * Copyright (C) 2022 Christoph Hellwig.=0A=
> + */=0A=
=0A=
IIRC David does try to get rid of all the per-company copyright=0A=
statements for new files.=0A=
=0A=
Other than that, I'm fine with it.=0A=
=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
