Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0498A50F23C
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Apr 2022 09:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244285AbiDZHZQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Apr 2022 03:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343954AbiDZHZJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Apr 2022 03:25:09 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57953FBD3
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Apr 2022 00:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650957721; x=1682493721;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=aDWI8nbmRzO2XcewMOOvcvF+v4gTU+1+mnavplwLzsKv1M4Wf1s3ZpOz
   +iqklerQXI3J73l+BduBxhc0OzJih6t84lZNPo/6CWkdljwyZBlHoFCGA
   9EMNBx+3BakzCKrDY7kO2TcRaW8HXzpllzMayZF2QLLJoijltcIab+44o
   yir79fx9QA6o9syys21nze4K5HILvt7bRq4xB7GOblJ3kzTKYtxlu24Il
   z10XxsLnAgz2gk4qq1E4hD5lynRcwwV1a5DKfe4W40lfBJMadMGz6RBhg
   /Ja/+Qn8+n802U0W6GQZH8rZrTqMFESNcqSi1kLLz34px/BKo4m9bhfyD
   w==;
X-IronPort-AV: E=Sophos;i="5.90,290,1643644800"; 
   d="scan'208";a="197677056"
Received: from mail-bn1nam07lp2048.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.48])
  by ob1.hgst.iphmx.com with ESMTP; 26 Apr 2022 15:21:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N6j21vwO15CV1QzjaXMXNiCUzUUF/vK5XdIFJp35B6rIPeEInn9TkauwqXUQyeGC0qu+JwCu7noXcrKsgmOBLjD4Fe0EMrcyzcjt6L9gEyDQ1Muq5Wa/NNnBWPC+8YDrX/E0RbmhkU9HuJuiL6E2qsEtNeLWaa1+DQ9HW1VtcfMAGkY/BhjEpNSTgA2eIKAz9OyowczhXy6LFoLhd6NG7Ku6sBgtJPmKxVwa/LFlKHMUecFtG3etqQF/67aLNcsRH1/HTIxlR6VRv0iiPQ3UWJlN75KyquQmA87L8mAYLuk3Hfd59qSNjYdPJopBZf4zCXIZAafD5yxZxqgF954Pkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=iQCCvZQD12UL3/CSTA0fGyCdYdb77EVBmae4aguAPFA07H9oHoUhTwUQ5LXZ0GLON9RHZ5XXi5mwSRFScUfB2an9iRPy3bHYoEeiHjd1vbkBCQiY5ajuzQj2opC4biCrNbuX4JZvJOP3IL+EmW2PHC6EANaAlJ3+xOOkEzZCh6qpBWyGHkoHeC4hTvVCyOeoTTbIprlc89R3trfoMAQYzOVyUH72SgXXcXbg1J+MiSApbnYrgLj4m1CsujP0fbP/I8mhMTiYtxuy1S5tjwiVPw/M4y2MkgXVcyBrZkI5V1MVT/Jtkq8J/LVfEZD9hoBItzIXCM9OAHNq2v53ibPxrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=ciqlY5UY+XuLeyBBU3dIxNB+gAe/Di9OaFMSNRE9+8D98LhP+xb9oOCMo7xwhBjd3pxZRDQI49Ff5FhTBMJ2sGSP6sifz7Aqzrsc1g9sjmwZ2EjR1HUrBQO9M7d006vObb/5ZuVWulojNasC3rw54FK6K4SqSY1lVLd400eZugA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN8PR04MB6130.namprd04.prod.outlook.com (2603:10b6:408:58::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Tue, 26 Apr
 2022 07:21:58 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12%3]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 07:21:57 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
CC:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 02/10] btrfs: cleanup btrfs_submit_dio_bio
Thread-Topic: [PATCH 02/10] btrfs: cleanup btrfs_submit_dio_bio
Thread-Index: AQHYWHoRcQAPupZWdk+yvZboWYL+Cw==
Date:   Tue, 26 Apr 2022 07:21:57 +0000
Message-ID: <PH0PR04MB74160D955DA8C3ABA41F372C9BFB9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220425075418.2192130-1-hch@lst.de>
 <20220425075418.2192130-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 779c8b89-dcf5-43c3-fa15-08da275572d4
x-ms-traffictypediagnostic: BN8PR04MB6130:EE_
x-microsoft-antispam-prvs: <BN8PR04MB6130934A296E8ADB7EE9E3E29BFB9@BN8PR04MB6130.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kMWq7TWRik5iPDn7HUqrrCQ47BcK3JbMzkise1bHhY80LlGsh8p9v4ppPTxu1uylEWZ3VXasUtzIBhNBHWavkHXEoH8CDWOS3WD3nDX7RLNhdew2qQKVD71ixH+9YhfDKGJbXYyfB4/tKwvQjs/uQbbEnQueE2dBaMBeEI8+tVSZeevwU8k3R9w6mE6jVsrTfiJQ8rv/zIw7y+RqKljLxl7kxWBnVHV+SVBQaT0VwFU2oYzbXgglGhpwGLNaEElwUuL0BSnI0d0/Bv/jsao8O6bwrCRZjRtRCMltAKGY7O8NW1fvt6+ckWkpdck171DCps2InQKkkccqfA8PFVo/M33ainvSY3gpcekv5+AnDbGcMl2eQdMImYz/3ILY/CeJYMkie1EpkDT2q0DGTEu1z5LjQ2NU2L7spTTCvzCWoaZpij+oP75zCo5HvSsXyxDzqgBhGEMl1zpM+BPEM3a68vGEv14IaT4jzaeJRjYf4/zPlUVHo98gujHc8RiizBsRsw/+lZiKc0v0Bk87+ut+U40m/EBsVr5zGlBptZm6Xwmy8CsjkPTtDIREQbvOW2FBxvPHCP53oaQHkQOvRAUmtzuW7tJO7OYGFlJLAPA1fZ5q/0oEzdVkX8OFspxIiKdExCEXaChnldViaIt8VRISMxRSnDnZeRtQMX9snapcxV27k94dZyWBX2aPwUOssHL8L/zxstqGo0KiQV9GglJrjQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(4270600006)(52536014)(6506007)(9686003)(8676002)(508600001)(2906002)(82960400001)(110136005)(54906003)(122000001)(33656002)(71200400001)(4326008)(5660300002)(66946007)(7696005)(55016003)(66556008)(86362001)(76116006)(66446008)(91956017)(66476007)(64756008)(38070700005)(38100700002)(8936002)(19618925003)(558084003)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6VSIblm3AhGiCHf6me/NqwMkFR0OMjjwscWBUMrtj3RwaTT75dIma55ZlCZd?=
 =?us-ascii?Q?DxhyNQogJqVHWkNeEBQJAW1O/VWrPY1PI9JfrJwpui2e7T7SwbMieElu9dk4?=
 =?us-ascii?Q?agiPxn2h/yPLOqkWnOx0jQTBcKl3HU9Lrg3hbW6/DWptRXM90C/YEkYWD7Rj?=
 =?us-ascii?Q?dTglAtT6tZwzkpYJJVX06dH0P2e4lo4zo/x0RErbNQavAMYOnKkD0yUKMrxc?=
 =?us-ascii?Q?luEPjyuY2+7f6fr5H1CawU8DD9qh197YNLzTxgL+Z3ru1F/aXD54cgoRt2Gw?=
 =?us-ascii?Q?dG4bWx1WEwizPJuN7FxUifWmmNeXDcaiR9e7WcOeXHBD65terrixqtOBV8H4?=
 =?us-ascii?Q?BxWAMfDjzjK2dWUf5OBTAoAPVaWCcpNF6EVNvwEYNbvFhEUjPronrtzGnDjj?=
 =?us-ascii?Q?I3/kxPQbovlbxFIu3L7L5C+IZayuSBd3ZTAdE3qO3Jt5/DDoku/SytjrdBS3?=
 =?us-ascii?Q?UU33f6KVnOr/gtWi6IyGKLAMrGUAkaZm17oP0hLU4NucWwqdD3mJGmm9j4vm?=
 =?us-ascii?Q?a0+8MUTagvqWxLC2PEWLlcd/igMuitpuxKhQVFqZzSreGFxxrK88ozsV2kbg?=
 =?us-ascii?Q?9ujzUxTQWo75Rw3DqCdJuaD5GGP+ReAg8RosunSU3IxwpQvKXCZh8xkM92TM?=
 =?us-ascii?Q?hoTcOcDok00hEnqWLC853zRx6qd/eaPNZC4uRYyPUC8eVuOz/0DMksx4pzOP?=
 =?us-ascii?Q?kOem3vDlMiV+6TFlojx0+XLjqgMpDcwG5n3IxcQLlGl3ATtTTkyrHI3GhFCY?=
 =?us-ascii?Q?38xjF3Emei7hfCK7kMjuKVIlhWnzQnq3qAox1pZEgzbX4r4c55UtHYyiFo+/?=
 =?us-ascii?Q?fPNcmAaE/mNhKxXCyGPFUzgPY5tCOV5bOdMCLbw2nBxwLuaQUYBcx7A8GTtn?=
 =?us-ascii?Q?5l1dMiEgwVrEumiHa2OLzqkudeGAaZm0LQvBVHJnhn79A1SOW6mxECvXVxJe?=
 =?us-ascii?Q?XNBwyfEZ07bwbjfcFxpwoW9MlgokMgjToTjSSs4we6rwsBSegADQBnc7c8wr?=
 =?us-ascii?Q?mbGjsL42VRRrhGPddZ7Ogsr0/d9XPdKgNAeIJuZAqs4N5A0LVKXcb4kekqIO?=
 =?us-ascii?Q?w0PMDol1X4og5iWpQVuiF8tG/Np2COXbQ2Mv07oPSmLzAsmL6Z7NhvekwS3W?=
 =?us-ascii?Q?LUm3lChQu/sMyEZjxDXBBJSzYYPo0jPDlc2IkdlR82UDTvzZjRfsiCTzdhCU?=
 =?us-ascii?Q?ABLZaZfQzbyjnNzTPdtnqA62txxBEbZi2buVNM+OHAhYa5qd0LG2a/yPOW/Y?=
 =?us-ascii?Q?ooOEcQOtKChmgufxg2OmwKFH9b2fADGCfYz2japdDwwDQmVoXK7JJ6xFPJ5D?=
 =?us-ascii?Q?iLqvrVjBZ4tyR/2fgtofEfjTnYSkbww5rvmek/sc5UzkqvT5AawcsGE13RBd?=
 =?us-ascii?Q?Q8xjxp8axoJXt9nltRGUKp85HNXFIeOMIXt1573/V4X27Q6SSlEfzxKetaK8?=
 =?us-ascii?Q?uAMFCPuwKtp2NvDrs0E9wfGVOOtDOKt51O4fn5TboYAqVrx4WDe4Ed5V08SW?=
 =?us-ascii?Q?ItE2W2shs8jXJujlRhD2D/n3c/5jZ2GKDBwgCdli0X4a848mi9fM2Jhw8c6a?=
 =?us-ascii?Q?8zPEBdufIAykN4eBv9ZK5kIJYRbeI+j8ayZaSu8wI8Cqe09Z17WFU4jrWe3+?=
 =?us-ascii?Q?hlyj9jzeTaBnetul/AWxbjAEEqHH0aDrhCF/uJCUilMHBTkANm6A0yh5YQWS?=
 =?us-ascii?Q?RFuiDGbghMCIzCFAVmD/cfur+gzJ673fLcIIBIUQphQNZ49o2yQkyzBufGTM?=
 =?us-ascii?Q?7LnrsMH61xw2ivNxt1lsDJbIUY80Ol0xfdh5yxxTI4Jr3pW8VurYSz1thIoW?=
x-ms-exchange-antispam-messagedata-1: cguNrjCpviPCxVaBvytwoU4yZjGgcMyg3TLiTC0fwmD2Xc25EBcfVdnh
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 779c8b89-dcf5-43c3-fa15-08da275572d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 07:21:57.8141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Hz21tohlzFbgMiJWAgcHYdIOBXCUiVEy6Ztb3a27l3hb7mjHaPh99CWt1arfJmYLCmwfVj2fBwZq+F3rVyoL96qWGtzuwsKjPHF7RMsWMI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6130
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
