Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62A0D34A2AD
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Mar 2021 08:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbhCZHqh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Mar 2021 03:46:37 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:2280 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbhCZHqO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Mar 2021 03:46:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1616744774; x=1648280774;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=0njJFcbXvXTB9309v2LLTYODgDikBcGov7/t99CU/DU=;
  b=mBf4CvfBXITUlQBTPzFc9ExCENR5KQt2TPVO5nN38uXFq9PFmnmRCy7a
   TZrtdjg8wFfzXZj0aF3xOCIQNXLXabsARYvt8lBRLU5L21Ay0h3XDjmyU
   5zbqhzB5+/Z8s8t6fgTXpy5fNrmO4lN6lf43UskuEFah/pA1ga1sHUG2m
   GWiwtHuhr5U7ngNiOZNSYPVd4UJUA7Vmo4DBT1Rq4XKnH7d+eWZFa52O7
   VjkSNUiX0HOdI07jzovaP9QvFD3qTHxEMejHFJPUOqFhQQfixiqDaxGzn
   UAyE8IrytNFXJjuzoDL6Jb20sJHm2ocpoNf9VkKEgQVvP/+z6wBOU8jVL
   Q==;
IronPort-SDR: O+eK8nDSE/nLpyVhF6lP/jRtMYYGJKXFyXEfMpiQe8uPwbmqaoJBmgqN7r892QXDeealKKtcgk
 tjn/xQ5elf/YnOAPdPiwo1WEWS/0A9m1nhQnUo4Q9gciKoC9Tor8pgf48HDL+coe/s6aYmnHfC
 JPQ4SsM7r7Zw2hprIOPY399OHE1S0gIObhGInFyw7oC8Ady/kMioNIs+80rBiNLaMQXz2Cmh3k
 +Uds58yuTES2BwBtm6Dv5f8Vms0oLgsAxyJTSMeRooj3Go7d7/QELPAiAmpGCRBf79+NgRBkoR
 LWY=
X-IronPort-AV: E=Sophos;i="5.81,279,1610380800"; 
   d="scan'208";a="273844544"
Received: from mail-bn7nam10lp2108.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.108])
  by ob1.hgst.iphmx.com with ESMTP; 26 Mar 2021 15:46:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+h2horZDjsD4YY5P+2qT9aOTd9Djp4C+5hx6dNgVzw8HmEKysNbBuTU7mEyZE/ifoXcJ5fHGKRfvoe3Bgdjttkz/Ap/T5Pr+iTvIPOFc0ApBGh8153+l0XH9I18mGiHMXwHhDnGggZoRGJm99X5gKS1ARSkPz9a0gVuJbLiTvmqyUjPUCfDwPWkn5vDIocqEwbYEvobs2XlCD+qLDMOyojJKqOoTx2ID9O1e2y6w/oSd8SwbPN+/tDLnanYxGWCYIa5qHASa77Hrjoqa650/WxtoXXlP6MQabQGOGf327NeaN17UOQ7JWzDoJGN23bR4Dc0UtG917f+Ff1GF8q1GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLYsnuzdGEG6hQ7NmaSqbUxms5nMzZwRpk9ckjDofu4=;
 b=KT467DDDMWvuV4cDAgaLgyLwzgzWiScWqJxPcs4Qj4AwnnDLQz6RgWaEA9Ax2c6yqZycpmlm7lFVM+VVduw9Oq3AKGphNpxdNN4UVD57cKfVn6R9MPS/3A+iic9VpoE08nh0Jp3NpgoTbEaeyD2QYuRQVePtN6c9E7EH4N7dM/yTFOrX6bWgP0XG19JOq055B6GgnPnTbZ9jhX4qPhvjvHpnVzn2Rc4zuo874Yophjkorb/k2CxohRE3uC48+hVnpVHXdll+WpZFsmEL8D3HZmFux6jGJwoSUULVAypm1k50z5aPTq4E/FqABkfkanxZM6EIzXMzU1uRKaRQOKWHAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLYsnuzdGEG6hQ7NmaSqbUxms5nMzZwRpk9ckjDofu4=;
 b=LVQSHR/8+6Lr/6ERnlwHqrBfttmwRpw5mTCYAEi3a4yk8Q4ck7KTRtIgvuHjW3HuB8yaeoC4QnJkMePWvlSbC9thmqnr6AbU29o0Wg0Yneuj4cGCWyqLS3t0PZY/zQxbxZu47376Z3IJH+HMO+/S46GhggORK46hoZ29RV0s4M8=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB6984.namprd04.prod.outlook.com (2603:10b6:610:94::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Fri, 26 Mar
 2021 07:46:12 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::1c4d:48a6:b00a:1ce5]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::1c4d:48a6:b00a:1ce5%3]) with mapi id 15.20.3977.024; Fri, 26 Mar 2021
 07:46:12 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Eryu Guan <guan@eryu.me>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Nikolay Borisov <nborisov@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH v2] fstests: don't relay on /proc/partitions for device
 size
Thread-Topic: [PATCH v2] fstests: don't relay on /proc/partitions for device
 size
Thread-Index: AQHXIhMXzFqWtGHuQ0mqmuxlDys4Bg==
Date:   Fri, 26 Mar 2021 07:46:12 +0000
Message-ID: <CH2PR04MB6522F59F0B14B2E7A2410F13E7619@CH2PR04MB6522.namprd04.prod.outlook.com>
References: <20210326073846.14520-1-johannes.thumshirn@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:8539:9440:76cc:73ac]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2426db15-ea3f-44fc-7c80-08d8f02b3a70
x-ms-traffictypediagnostic: CH2PR04MB6984:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR04MB6984FBE670F1AC32D547C6AAE7619@CH2PR04MB6984.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zPjaVBDtaKP/XFjOCwNn9XsobZUqKrG5BlRVP176YriuDAQXnd4WPAj5aNT5OrMZD2KSxvXlVnxl+0h/JjfY3mK8XTiojKzaVsSw8pXJE+cQqPRxbSeIeWetADrdMdOk1qjsmleT3feblQC7TH33SmNUpNzdY4wLsM2alde2y+ZsKRzwomdypBM6/bKWXoWqdpWPFneWq5DTIJEG9jV/p5K5/vbll2kL47AjLoBUOi3OOC8ZcOT4NNOtzqjYREis7Fl50o+ncBOSmQl34JtrNCvriBmvZ1xEitOh4zKFkWXOD8t+USpPxVec+IRsaUlKYBZ9bbtPXvJbPfNo9qi2vg7GPYtb/ZejSrvMXk2DSskvRP0dkb11sbJuDXYvTJc2hpXm9z10ggB3dTyR6B4PsDZtKdbcZkUV/nLnKkV7jCQBCphkTKLO9E2oBy4LTNCvi8ONUzjmfo+nI8zjEB+5gtfT0kenXG720MBDX7lCeUeyXLHLpvI9akGlCUPDhR2P7aVVJLfwY74o6sGGJ3nax9LV7kLiMwF6g41oXkIHnYtqu8Tl6cy6Chn4PG3BsFqn81QM2Eg6ow2qNJJjYkj1VQn0mdQfFQW0KMwU50TN+APbTD3XXJYQlN7mDeNPtcpRiQoFShAYm31473m1Hbk/Gc4q2SyFcgbAWNh+zqS3gM8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR04MB6522.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(8676002)(76116006)(66946007)(91956017)(53546011)(38100700001)(4744005)(71200400001)(6506007)(8936002)(4326008)(186003)(86362001)(7696005)(83380400001)(55016002)(478600001)(64756008)(66446008)(66476007)(316002)(66556008)(33656002)(9686003)(2906002)(5660300002)(110136005)(52536014)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Yyp/vXaVrgO/z5UHnFtVN7rSwg6aYopkmlgRu8AYdHAKVldJpRPFRBSznekQ?=
 =?us-ascii?Q?uQRtUVSs/AgVLvozkSivUXX+TYN3KbJOnW/0jjcBKTCT3YN5iWGNteTBuxJ5?=
 =?us-ascii?Q?pvv08SBk9siHklxhBqe9WHfb3z3bIunvD0jLl2/AqzfjikXxIUGxb4eWurgh?=
 =?us-ascii?Q?YIwWG29o9CR+F8aeG25f6GGeSBFf1txnd7l9CMf64Y/hTzlxb9Fem7XL34Fx?=
 =?us-ascii?Q?P4Wc3zdXGpTNrSJhH/OvP5OYn6jEiknrGtvrACvfJjVz+C1/dgRe5UP3Hudv?=
 =?us-ascii?Q?tZPslWIwUllgtk4COM7I8XbzoiS4IrT5EVlK2eBweNO4ymp8remIHpTezSMu?=
 =?us-ascii?Q?ullUgWc1KeAKcT9GIng0uEyH8XGXIvvFr/egnE7YCUoICQ6uue/HdJl6o2EG?=
 =?us-ascii?Q?uGHTG0j8I67MjUvn5F1WcgG8a7SA2eQtWoTGh/k7n31ftA70QlKzVhUhHEWH?=
 =?us-ascii?Q?vtWa/ril1WGVQzz0+epamqXkJ8Iv2DGXFgCQIvnW969qPmMF86ECIQcC8GQc?=
 =?us-ascii?Q?a1allv6SUf36UEqCdsSqcCLgc2plBbGAlcVQikA0aBYrD830XnRC0j5j4FfB?=
 =?us-ascii?Q?xd/0OD/9Cq1mvz9+lBjqEykUcutRMM+Jpw4Ycmim2YxBgnTAU2JfgTJql3yr?=
 =?us-ascii?Q?s9FNKFVMXPIqwGu4InwQtmpPgS6/7HVLMVoCNMO6ufhB72kF2F27JSquJvmg?=
 =?us-ascii?Q?nRo26/5bUSGyswo/XBsSRewPwrx/wStsRDQb2WGPsd6zLZT1jXkgtbFDdimg?=
 =?us-ascii?Q?6pkr4uz4oVpi0nvkRiaJaPifsOZ7EjlseTsGdwi//lafWSW06wtsGr5QpVw+?=
 =?us-ascii?Q?g4JO016F/xd1isxTYAMEaBod6FVIteNgLKBolE8Ig7t4kaf9sQdZKXUatVNo?=
 =?us-ascii?Q?oifYk7h2qO1nnW+nuOuJC106WJp+LjzwxPb4Me+E5NJqhLfCEN1Od9kZBa1U?=
 =?us-ascii?Q?ewP+KqSnaGAAC8fdYvV27TSH/Eh37m7ooYdEZkN8177GDgZs5qOH5HgG1dRE?=
 =?us-ascii?Q?peTk4ckLTyltmtBb7OG2B9rv/n/fTpX9BIgowVkJRRigigdoWLZmSg4ZTFCO?=
 =?us-ascii?Q?5PbMld9F1IHSlaXsbu1fr50GwprQtDp0pNvVQM++1+L842L/rqpY77+UBBuB?=
 =?us-ascii?Q?VIiLNoPqc4EcCHTB5eZNk9B8J9Z3r2XzRFPrsUmynnEa8Ph6Al1S37Rdlzsc?=
 =?us-ascii?Q?WlUmR/51VhjDP7gY5TN9XgM468byUCxqbRqjYHqrk2V6kr6zUU9Oex1QgnIr?=
 =?us-ascii?Q?ZPIGnnwoamqRB6VK4J+r61zF+NHDy51qzOcyjFDLJPMfrcJ5bvAUHF0u5k44?=
 =?us-ascii?Q?27zp/bTl33L7LlPauWykorNwPgjbL+walrVsFx6bGjRYYhGRNd8IK6WUri6V?=
 =?us-ascii?Q?MwS1S3q0A6ZaMZFU+l1xJYNRo3wL77t3TseYxN7a+ARwByF5/A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2426db15-ea3f-44fc-7c80-08d8f02b3a70
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2021 07:46:12.6261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZNic1ReZuIwr15ikH3E57vio/JY+p1lhrJqO6B3qeDCmBaDINcQbin5njFkm9G16ss/UzF+hZ9ouOgK2DJ6WjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6984
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2021/03/26 16:39, Johannes Thumshirn wrote:=0A=
> Non-partitionable devices, like zoned block devices, aren't showing up in=
 in=0A=
> /proc/partitions and therefore we cannot relay on it to get a device's=0A=
> size.=0A=
> =0A=
> Use blockdev --getsz to get the block device size.=0A=
> =0A=
> Cc: Naohiro Aota <naohiro.aota@wdc.com>=0A=
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
> =0A=
> ---=0A=
> Changes to v1:=0A=
> - Use blockdev --getsz instead of sysfs (Nikolay/Damien)=0A=
> ---=0A=
>  common/rc | 2 +-=0A=
>  1 file changed, 1 insertion(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/common/rc b/common/rc=0A=
> index 1c814b9aabf1..40a9bfac31da 100644=0A=
> --- a/common/rc=0A=
> +++ b/common/rc=0A=
> @@ -3778,7 +3778,7 @@ _get_available_space()=0A=
>  # return device size in kb=0A=
>  _get_device_size()=0A=
>  {=0A=
> -	grep -w `_short_dev $1` /proc/partitions | awk '{print $3}'=0A=
> +	blockdev --getsz $1=0A=
=0A=
That is 512B sectors unit... This should be KB, no ?=0A=
=0A=
>  }=0A=
>  =0A=
>  # Make sure we actually have dmesg checking set up.=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
