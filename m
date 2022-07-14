Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A17C57489D
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Jul 2022 11:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238209AbiGNJXR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Jul 2022 05:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238104AbiGNJXC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Jul 2022 05:23:02 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F131C40BE7
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Jul 2022 02:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657790492; x=1689326492;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=LgsnY0kj4Hbdgi+diAp+gyNOAJYY7TdQxeJUkXAuD3+diosB5iLVRFoD
   1yD0ZTU4WGYTe+D5tvXuCLSZhrISGQb6ayvalrAOuyGHoz7W/nMvQ2DwW
   5eo6mPLCd/3DE8HeAQa+/2Mi/bHxLY9mii3Z3r9+mtKPY6CZu+yUC+VbG
   EAV0M2ibnmuuYr0WXRnVWoqG005Ks5HIJyrHXVet3KXmxneXGtWpxguAG
   oBS8pcby8IysZvZqkGvzzNzS7dPz8czkmohQmHlqvb42/MSCHDpAZy/aD
   9eM5CrhGA7qKMmuHVe9SGSfj6o5m4jGt69hDVcaGw0t6LTJOuUc/V5Q/m
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,269,1650902400"; 
   d="scan'208";a="310039240"
Received: from mail-mw2nam10lp2108.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.108])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jul 2022 17:21:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nwDxdqQpq+KRpVSfZdNwLVAGHH+B3STed+9LB2QqC24yH9fPM96B63p7S0lh7ixJPKXZQndZ11oMxiC7P0qRBfEGEZaYHyRgX0xiM/5H2qgFALyFFCUaf5Vk12eiktiPMD/YrrzZ1/8fchsaJHVhTknp/3ym+b/U2M36d00BK0mY1xUcg7QtWmNZc5PF6LarPNzVAI9RaPwoucH1ltrk4NHGFHcMY3E7X6Ly+8FUUi3jJzgBaa+1/H68lHV7FoYhelGi22v6fe9d1SGkFYYp+gzc34f5nQ9H7qDY0wgTG2PRq+mlv5nYavISFcY5DPSHS+MrYIKFdQ8tOFVrDGc/PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=A+nSJ8uktcGArg0DGWrOS8qf/SEYVz86lLew1YB+iu0WajxWo6Do+x9Kg8RI9oui4R14zZ1kOc+rYB7Sqx74I8uZvCHxp78FwYl4rlsUaUDXijp4JkdYX0l153TeIpWHCszDv2HiqXj4FAYCV3/t+pCb2JUk7yq7d0SO7PYUKuq4ujV4Ahck5P6D2KAPernVLmvxVRX9tQeAv1oGIYf8bs65JfScV7NFUJcXZUnsn1IR1kXVaIGH5bX+sEPJ7/nAeT0cfUq0ZCGmPTnlzFhVkm4VMlBpBxhW/WTKjPibEU5T0WYXvjwOxBvI+zBiLJ55zWLfgaFOr16svSfvP5ciYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Of5A6yV+vRhq6XWU2A2hWEjKGhMlWrrmkQxi0hzu30A+2ZMKMTCIdH63mYtmNLKz6kuCh57cHQmPf5ldpSa28qfI6ZAUiIIijsl3gR6HGjG6K3pL5xy/RJVnhkd9ck0JjJm2ZItm6yJEnYkuUZL4Enlit/kIEx/bQz5MjiNONm0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7240.namprd04.prod.outlook.com (2603:10b6:510:17::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Thu, 14 Jul
 2022 09:21:30 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ccb9:68a4:d8c4:89f5]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ccb9:68a4:d8c4:89f5%7]) with mapi id 15.20.5438.014; Thu, 14 Jul 2022
 09:21:30 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: align max_zone_append_size to the sector size
Thread-Topic: [PATCH] btrfs: align max_zone_append_size to the sector size
Thread-Index: AQHYl2LXXyQ+rNRsJEug8s1GzTbX7Q==
Date:   Thu, 14 Jul 2022 09:21:30 +0000
Message-ID: <PH0PR04MB7416DFAB1686BADFEFE900CE9B889@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220714091609.2892621-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f3cf968-cf38-4bc9-fb67-08da657a3c93
x-ms-traffictypediagnostic: PH0PR04MB7240:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KOBQvQCbOvAcKrHHIQXJPb/9mlMa31MmuPb1I7P+ZeJu6cEGKYaV0sdloR+4WuQwUck7r6lSeM9ZN9dxOBjL1rg9PtPGZ4ymDdqsXUTrS8YD06nf1c9Eq/w772fHU23S8ojGum+TZOq+RJm7QMOv6/+UGxRxgYii+r1AC+ALwlVz4dgjucsWc9pjms2voGWSDk3qNcYUI+3+/wymMtFJSmKqG5KK/6ucVsAtN3+WaQGF/ps9hnzZJSBYjTXZlzB8U8/iqnT4b6on4B20E1+e33YKtbh1pBAK2uun5fxX6T9cU8hoBZX10bq2eA9u1O798FBRLOPSeOVx5PcBPdEy1HuoQnqWX3/M2RGA82sq/SS1FvMjoP8WAuyZMfEi8kWgnupEhLCIQJhLmiK/jnGyH1U9IEpVT35/l2huBzwJzpx2noDPMm1Z8Tflkd2SMHDGJXbPRz4MaCPmZETejb6KaL7uY7wgxHmmJpyAXGIzsqpGa0+HgmEOn2o6kHMCuT27nLRkCBmp41kt9jjUeKTGQKKVvf27ieEtBEP6CV17CivwbBeW7UZvWRaIQ+XCS847lf2PxZOx35nzj3WaAW95ioi1rs/R400cOkq6/a1nq7cRzC/5JF1MTklOXWEWPhGf02KESR2OLiv2Ft1zY5PNC7rK3s3vjGl4+m3AOahiJwZ4j6KoO8caiZCzQ5m38cLao4SAU7MiW2jICdb+XapucZXNA5n2dhwiVRsnPPS+d+8oqKKrAkv1pf3IHd9OdKOZs5y2xL99H2U2WESWGbIp+YmARtfKWxZ+UXowe4gCXpvUVP9/Me+fkJLI4W7L2g2y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(38070700005)(71200400001)(4326008)(478600001)(66446008)(8676002)(66476007)(66946007)(76116006)(66556008)(91956017)(110136005)(6636002)(82960400001)(316002)(64756008)(122000001)(186003)(7696005)(41300700001)(9686003)(26005)(4270600006)(6506007)(38100700002)(19618925003)(2906002)(33656002)(52536014)(5660300002)(55016003)(8936002)(86362001)(558084003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?s3H2ZhmkgYo34XgtR1vVHXPv0Cl083DJeM5QG7+6WQxQN5sFAjfEyfebuZjL?=
 =?us-ascii?Q?hvp/1WbNIMd6gGr9jw5hABLGHltOOo3exG8tKdc3Mry6oxsmBBLCyN0D9XWX?=
 =?us-ascii?Q?qmrd87HDXb/9mRGQcvtg4hcvXdsmaAnP+bOCKxWhgU9zXGLP3f87HM9GX18Y?=
 =?us-ascii?Q?+RYB8mZx9YUtf2S/q1v+JEbJdzoJkdnAOjOTYwGcxFL/3Z3j5oCrId+KHZUU?=
 =?us-ascii?Q?95u/8D2IlSG3wNEGWvFUZ6f7inJaJKOtWEQFzux8zlUs7nwJ8g+JtFAoqitA?=
 =?us-ascii?Q?5ijDdP9RwK1hTTD0+kwGDhQrH55kFYcDReflebptV3nJ7VeSWW6Vkjll/Lpb?=
 =?us-ascii?Q?Dmu8AKPf9In2xG9YzNvvv5sRuWii4fxMXNQKc3xM3uaf7h22tUpByOjsbEKU?=
 =?us-ascii?Q?/dO1psfXIX3xEelEofO5i1iKI9HEyMLC0nAefN1yfaeOao/5holTz40/GjKa?=
 =?us-ascii?Q?3+KLSdwN/7w2dDGX5eJ9XjrbWV8vq8rzFqdJxGKPDEUmI7H67yytj040ZyER?=
 =?us-ascii?Q?THBxxVHPF3cCrcIHTa1DBWClK2lwCNPUL5F+wtxI3spGeRMe8K9wZV2cXcCj?=
 =?us-ascii?Q?/aHTNCd2QXght+5+Az8cZE8floxuseqVVc6h84ENpDdmkgv//Cym1Gi/FmOk?=
 =?us-ascii?Q?WL1mWf4teZ0qiw5FfZurxTLYykiFigj19RfBcein1x/nnsHTEPtcm2p9NgKC?=
 =?us-ascii?Q?LAEKwD++a8iQ1bECKF3RXA2MVso0wQS1D4kJh0T2brNq+7oZvj/ZzCKZWMnC?=
 =?us-ascii?Q?6QfCsR2IqGV5sKJ3Rlh8/ibjr3ukaXb+DseNhgVzPDJzC+/l/0WVMVRh+Iqf?=
 =?us-ascii?Q?1TMlKmX+7TmGhNz2lqdFPGuTo1bkB4aVU+qZEtcKfb5GqoHW/ZscAOgbvvFH?=
 =?us-ascii?Q?wzbLxc6ocgPYIbbprmgQ4zP2NbzXCfkIE5eoLoycM4Q0nNFz0NpNXc4eoBA3?=
 =?us-ascii?Q?rY2B6gpgfJoE7ZCiHNTj5BwsM5349A0QVCTb2S94e8NAMc3MlUtVDvrsWRQz?=
 =?us-ascii?Q?qRu57E4/MD61TGm8QMZ05eYo5laGtVc9xrtDwmk15ebYIxa4o2Lot+POibld?=
 =?us-ascii?Q?Jkqk5hS6B2bjLLY/fIFMaIzsdf9zx2g8Q2rQh8NYBxlrKFKmkS3M2Nttxocy?=
 =?us-ascii?Q?GWUh/wH+tE+AwKZh0dLL+0YifI72Jp94FXu6KGo4+Te+VeWuVtS/ZbBeFtfi?=
 =?us-ascii?Q?eU9RBD9/QpL8lpPjtMY/+YwuTlDC3j8F9JY5d9GegHOhGfJq6duytvp5h/7V?=
 =?us-ascii?Q?cY+pc1YvOjRlHmbVjoTHBtkbxEs/p3Z0ARitafcnpLkceS3BrUxmzRKuByuC?=
 =?us-ascii?Q?3g92+3gU8vUPd63jKePQluWYx+YMtfJis7gFJi3if1NLnlHh1c7/+0SUGlxn?=
 =?us-ascii?Q?J2pbHVeH3TgNsL7cyvhQOHrpgoyjyLmy3YMwts4EGU2TpohK+vvq2pcPvDKJ?=
 =?us-ascii?Q?hP7KitQatnIjNqaCrpBBNBXte5c5hhKqUG5IhxyMJZW5o5s9j2SiFYDc9sSQ?=
 =?us-ascii?Q?7IRLWYO8/3TbQ3yBJBN1c6E5hZZozPlRBG6/DbZx8wELQabUyezE1Sw2wmfr?=
 =?us-ascii?Q?PIdJmeFd+SKDuZYfiqNC3DIXHPdl5Ophxt550noFa5zbcVEXp1fl5sHbILp7?=
 =?us-ascii?Q?AXyjlff+XkLbyyQkaJD07I4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f3cf968-cf38-4bc9-fb67-08da657a3c93
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2022 09:21:30.2780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: noUjivnpEmNPAOhg/Ex7cpsfyio2AzwPidjVaXhaEqncX1lccjdYCYYlqZjDqKyX8UbHZ6fXHKHaX2YneUEEIiVXB/OV1GngOzMPxeDCH9k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7240
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
