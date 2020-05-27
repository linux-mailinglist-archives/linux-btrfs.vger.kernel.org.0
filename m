Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 596391E4105
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 May 2020 13:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbgE0L57 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 May 2020 07:57:59 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:33868 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729959AbgE0L55 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 May 2020 07:57:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1590580676; x=1622116676;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=a5VzF84F/D4cl4ijSsNB1D/wiCeloJpg8sl5iqMM/7wA6tATV8UM30jY
   dTaSYKCaVYuvmIZ/GxmDcF4YXEaiyYKfAMANjMNKyRJIom4x11vWo1m9P
   AEpuolROBJzQzUWyAK1k9e7OGebJVUCkX+vF5fJBBl/I23AgLFIfSja4a
   93q6haGSwLbolF2jUYSgR44F8j49UsljjL078YaJtY7dPDHFZCcBDmCap
   L9BmZ7q+OPYrd0c/6neXcCvUhO3Gme+5MTopWQybJSQ+HIY7NR6dk8Of/
   Xk77tczV+8gc3hryvYEAHup4qI64Yjrg1ZLpxvdZzAwgrJhDnZQIgArqD
   w==;
IronPort-SDR: /2A/JSHH+mMZ4nQpFXDxzdy6JPvbHtZZ49qkVmKnYIIiQqD3AcITRVZjRsuJGxBTsThoTc3sLb
 2ftk504LfCo6eQiOP15qjRIeUhThINlghf+nNOWqOJPILXftQN4uuDyvXJEA9LGpFck2hOOK8F
 RjpUJLUSE1oO+CtOkc+MYA8QTpTDhvdEfO5sHJ37hACTYU0vZ5YRtFOMqg/bmJXfVaFHPqCKAw
 iezw7oGlh4Hzg6iAxCKkR2hfi6RcJCB8MFjhtNSHJDbCXq7JiViQeDxvVX/Qcs8+o/qVTO8xhs
 GA8=
X-IronPort-AV: E=Sophos;i="5.73,441,1583164800"; 
   d="scan'208";a="247663796"
Received: from mail-bn3nam04lp2059.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.59])
  by ob1.hgst.iphmx.com with ESMTP; 27 May 2020 19:57:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PNSiQEg5DlZg4GEDZEu1UhA9fuhjdBH8HQzVugCpO2onknZ2a+kk27wNkq4YZgbHjs3kFrS3j/Pprzlr8wDjmj3XABxqsTa4qGjQnzvxkP+LmAKnbG4mB86hIg00vaI7avJiEbPKuD4U25fXpsrK+PVW5cwOfv6XKVFTABLmOTfD+lTIeHgYvswqSfGRgaii2Ivd9O5QpBcOAnR5mG/czQDQkiIvsIu3W8de1bNMb4HETxeJvDvyz9UI/kSTH3BSbtNj+ZzJ+PT9GuxfICpze5OwMWQNSQkSI76DfFDAUvva8PqUof3z4IzvxersrVUpPcMQkyWOV8Ntea/qXd7RBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=dfpxavMf1QK7eScTO3ep2rqaBN4FqLdrwIQIH7o8KsedcnLumFqfr5onF9bVE+583VVCOoduwABkl4wWncblZLXaVpqIKIRZudNz+csU82kuoZPdlOkkrnMiEyRrrjVn8YuuGqG2E56NIhbx5qyE71cMQb2RZtsLtEo3dMi+k/1qApkbzry+CLsM7ZyP4ImvdCGY7L9CmKKr4mN7Y2KKbz6j3odXXfaLF/mgAktE//aoDgQgW5I66E/erOl2MIGdzVq7pYwfpkOLqBFFMr/I0WtYv4MYzEW7oj/YoB21ZXvOmGFioZE5lfeFYwelZw+cnafa14lsmEGELp1pV1pd4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Re4TZy6SUSBREy5wWJGBV3asEfmtDW+xlB9txHpqQBGJlhyuDw9hO7HeYnXy3d3GMkrcKf9j302nl0sl5T91schyADGcb9062P7HHlr3fwwdqn3ef8UCb5yPsoxFk75Gs9h+Thu/cgDaYhdPkG7+EYF6WvbT6xWgy0cuD4MBRsk=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3533.namprd04.prod.outlook.com
 (2603:10b6:803:45::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24; Wed, 27 May
 2020 11:57:54 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3021.029; Wed, 27 May 2020
 11:57:54 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: remove redundant local var in
 read_block_for_search
Thread-Topic: [PATCH] btrfs: remove redundant local var in
 read_block_for_search
Thread-Index: AQHWNA8jWQu64sWLKEWwwDtOcLCZbg==
Date:   Wed, 27 May 2020 11:57:54 +0000
Message-ID: <SN4PR0401MB359871307124BA735070B3E59BB10@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200527101059.7391-1-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f18eba91-c8ab-4627-b336-08d80235306d
x-ms-traffictypediagnostic: SN4PR0401MB3533:
x-microsoft-antispam-prvs: <SN4PR0401MB353393532C69B588A9022A469BB10@SN4PR0401MB3533.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 04163EF38A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IgUXmenO/nSmusJyPCQD42lHCSUTrGkJAyc3MJRogci8ZjWudjzO4YAIFlGxwoitzgDOvLguD+d7/08P/71FGGTkdePluzRXxnO93DOVX2d22L5iK7xCAANLuxC93a8RIdZamG4f8GU1aDLIvlj2U7CWNw2qCehycojxzt0fDQFlLPiU6J4H4TvOqdIEUEFa+Euk0zJnXoTmhA7LiNKUtdD4II3rO9WwswWkXmTIcN2PvWoofxjGRp1NoicbaNWHGjPPC5lZT51vWzr5TyreuNJC54VlDeEZLm8pLRikdI8arQ1qf1koRFwov/Avsq+AzRBC5V5KOZ3nYGuhjMRMtA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(52536014)(91956017)(478600001)(5660300002)(66556008)(66476007)(64756008)(66946007)(66446008)(9686003)(19618925003)(76116006)(2906002)(33656002)(55016002)(6506007)(7696005)(8676002)(26005)(71200400001)(110136005)(558084003)(316002)(86362001)(4270600006)(8936002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: VnqehKjc1nyK5cQR4LaXf997n43x7vBLqMotK+bGUgI4iCRz+2I41BPiTX3m6b8yWFMbPDqRktqrn9am5GOxccGlj2V5uiEC12wCMrkJQ2t0ZzVJr4LQTbQLL20ObKtJNa6kHNyWDikfkYq1UOWJeri/nqZ4diE6i/sO0tqsKBUaaVe12+aDCrehgSNbBbw+r5TvbBJR6kPTcxaY4MRpogui8XBHwcgGqfWNcd+UtdLGWIg4jVtAzOU8NSFLIHw7eiaNqNI2IYPFjRmr2VSLQkU3VWQSPOGjBSp1PlSHZmdeSB50dfi9h1S1i2OgAK7jN+0FnXqLGPiV/9LCRgzvQhuqm/2zJrpxi6PVZElhFiUE9eeCd25aC7E2MLVexFj4pzXCKXzGqkG7L8SaoS6szDGu+l2tpybIBp0HV0MxYLLYFUYOGSga9AWeub5KRVm1p/a4zpFYC7bEvYZqKufQssfKz1aFEOlFmHyzIfwdPm7yOc6XhyA8c0tkTXEfDNdy
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f18eba91-c8ab-4627-b336-08d80235306d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2020 11:57:54.0274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4AaiPkbeRMR4/hNork2jYpL92xQc9x0PU9DLmF67yDomPpi/HBs7sCGiJKaQ/muu1gF5wYJ1Y3xNZVptNh8e0G9jVa98tCPukihF7RS7I6k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3533
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
