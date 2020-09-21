Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE63C27217B
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Sep 2020 12:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgIUKw1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Sep 2020 06:52:27 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:11573 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbgIUKwZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Sep 2020 06:52:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1600685544; x=1632221544;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=rnlynXlUCao1dm3l5j0Vsuxkd19EsWXr6aHRsu7zK6c=;
  b=eymZqxHHdNNYC/cKbf+divB2Y1VoCr8pgTuuMjguZjQgDRSXImrzFG11
   qGpJsQ+JHuSR4x+UyHkQsovEIsDAHuAm1Cnb1ah8YPB6Oi+q5ftvCu57B
   D0gqgO83DGVzv7QRMt54383gTruu8i+9aS4G1lv25B2S/vit4ooL/mQb1
   F11G8N2cC8hLKCpQTq3d0TM9WfyWnB2UobBSh5uvItaJaM3SI0kERr4A8
   GEVUqAqmILZiq0+2Mf41TkFbq13fGF7sGNkEpvhsmWorfedDcuzUEjlmR
   o0ze5+sOkaeEz5UVTlFZD09w5FmQSHQaTC8/IKZgG6PZN6G64nL6P/R2D
   w==;
IronPort-SDR: ZooTQNVhk0zGci36umz3sLJ0LvbHMgfNj4qwZI5Ygi0wY6Zjba0EEg65Yqd2Cfxj3mNranpa8a
 Y7ayMyjMR7qDZ9KFl2VoJv7MuLJ6lY7U+t3EWXSiCrBJ2051HewnPXW2m6Vn+RMg+zNvMAJvwC
 a3LEHS1lc8NTL+AX/y/YhfwzuRvJexMtPr9uNDhJ8AoUBux2kDs5AnCHDdvBs2lu7fzqCi0Hwr
 deUdXlKwWjpEwlyzcDy/RjswC8eKH4+uynJhGj8mpsp+mBKG3mw/wkUvk9S75dK/3htQ+MT614
 x9o=
X-IronPort-AV: E=Sophos;i="5.77,286,1596470400"; 
   d="scan'208";a="147897745"
Received: from mail-dm6nam10lp2108.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.108])
  by ob1.hgst.iphmx.com with ESMTP; 21 Sep 2020 18:52:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K/AwYE52TSFn7eGm2TfJr3OlxX1DIbmVdjI+PV+oJpwYdpwTuSvTv6CdMpH1caZUKEioHGSVnRpl0hp5KTqZ8wBMCeeg16KbmLDc680KxGfaRaNKYq7MQqa68t1RVjhzOX2+GEjrWlc9LlmICiavURP70aCLqaWyEr88KnWH1fqZ3F17PFRhhmmGmzxKFXSqmPC5x0sRJtKILgtpJSev8W7ZJwMEw9ErpwvuXQQupPwVp6En3/WuhimzUT4H0cLWPJsHW8CzKvxSCx9Jq6euWDfPFrLd00tLnMU3yiR/d4XP7LIz+ikPmgCo4wj/TMJmWFk3p2fTiXtSKcvsHsvg6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rnlynXlUCao1dm3l5j0Vsuxkd19EsWXr6aHRsu7zK6c=;
 b=lPH7bM6lHdCvXAwi3N0CwedCHUMFoLOkF3rOWDE8crt22y1GaG6y1OzesQTvjr0r+D0fuj1LJNcb5aHTV8DufsgGq84pmQ314aP9d/zUei0Vo1N7Ql+pjssjaW0DUU6a/QyzFJ30pt1eX4vXQIECNnQts0Qsek99AXU2Bv02JHTmJOS3Vyn6rMqeDwUeF3d5yLbqPTFDUb7ASpRfaZ0Hi07sA4yhylxVB2G5VgcEMja49eawUWxgqDRVwhrHxAY2V07QGcFPMxJvs8L7mIdqVMuKijOhT4gIBLiR+dngMWIYOic2HZf9ng2F2/ooMcDkEIO9j05Oi8KXHqqRugRXIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rnlynXlUCao1dm3l5j0Vsuxkd19EsWXr6aHRsu7zK6c=;
 b=wW6HNvYeuL5E8kyzhPHrsj90hVPjsM7xEF4rc74/K4Hpgc2UKF7er82EgjYHLkIy7RULg0QokY4A2AVSTUwHnkRQqMbpCPavWhb84BJlb/lq2DyDRMeaCHYtiQUz7UtfPJsACzZLVj/f5GI9PVtuY0tHhlu9MOA6egIi8O+laVM=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4045.namprd04.prod.outlook.com
 (2603:10b6:805:47::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.19; Mon, 21 Sep
 2020 10:52:23 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3370.019; Mon, 21 Sep 2020
 10:52:23 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: free device without BTRFS_MAGIC
Thread-Topic: [PATCH] btrfs: free device without BTRFS_MAGIC
Thread-Index: AQHWjjAHxGCzaohAWkGL2VfRK7aP2A==
Date:   Mon, 21 Sep 2020 10:52:22 +0000
Message-ID: <SN4PR0401MB35985D5EE98316CC15DBB5DB9B3A0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <dbc067b24194241f6d87b8f9799d9b6484984a13.1600473987.git.anand.jain@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [62.216.205.147]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 56b10722-ad12-431f-ca2d-08d85e1c6b96
x-ms-traffictypediagnostic: SN6PR04MB4045:
x-microsoft-antispam-prvs: <SN6PR04MB40451494B79A72A9557B08F99B3A0@SN6PR04MB4045.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UUjXxg0zNWWIjUZ8k1Hquhb43REoIieGfPouzrcUI4X6LyTLBrZUYG/t/OcvThtZBnz8OkjSjp/bDBJiAm48EEC4w2kwkxGWWJdPjoR2KSbpMo6WHKjbQlDBjD35E6b8pquyB8QtPCuqzqH+zWcG8BNucUkcU6jHuhrkoKXse1Fro+AZS/FWWWEymE+XfSInXBFArITszGYNgQ63VC+dEt4UM4QwOt4sXCDA5LLYIPbIMyyaoYaMYqbsMwRq5LyyISCYwrxY7AirIepDnhpCSye2ayUkN4ZEcO09mGGAMy58oThLARFlB+9JHiNGS/1OpwnT0ZX490jBHLfIOT1dcA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(6506007)(76116006)(26005)(86362001)(91956017)(316002)(52536014)(8676002)(53546011)(66946007)(83380400001)(55016002)(110136005)(5660300002)(64756008)(7696005)(66556008)(66446008)(66476007)(8936002)(186003)(2906002)(478600001)(9686003)(33656002)(71200400001)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: OGV4RhHgcEO80YgfSebX3ZXxfvhN+wuydL1zn+3MuZQmOHMmyKwhJ1Sf3Ce+maqtaNp+xskygf+nvuFxs5wOFrMWsWwhSlsbsCwMO4kbSrYn6fxLzcxNmUm4JFJomK7g8u4ZEvBmoWEpb/V2QdVBecgI5XdzBbfhj2Pj1FRbZvPxP16wWVtJXFUIZ8d8rgQPXccl4A2SEHA5LfAxJvawVpkwIA00QOAuUch/1wbo5qnWm92AoXQiw4d1Cg1eCatgMzp0SsB+Qk5SXJ8S6Q0iyn/ZwczVOUt1tNa8AkTdDKJeFIVnsNNn3rZG1fPW0es8sEqLu8kgTKsLOdO3Esr+1qvs2EwymSqy0S/Cck7RET7w79sTnFOrRzplpVSP0SQKZdd4ySb5HmEZ+CQRWDwoIhFGL21P+K16qCW72XoyS258NRdlCxyNcJbPmQdZHPsKgaaZsGHMLq7sWxKMzqqjo6npaJ6lXiOBl2ZU6l9YzfEn9d/cSviCFj+rTV1IhRrDM8kFWslOy0kII/G2cUl0zCx/1Dbhz0Owe/23yogYQ7UWUq5qereSUXb76L1/RmmbUt6sXf9sBHii9UlWSFDsS6gazXgnLUvJ+nGfqT0063PaFLm0AkCm3tek+GPNr05xOMzfwB1vevA2Hyei5xfizQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56b10722-ad12-431f-ca2d-08d85e1c6b96
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2020 10:52:22.8415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: stuabmhxrYgLFXdVd2i85S/tvESq5Nr6AH2LOzqgZ+FiY3sqLYO68sGFGVLE4Mb7BpoRP+ydRENUEsD0YISHh4s+zZoOcFSHesIsNuBoXYM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4045
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 19/09/2020 04:53, Anand Jain wrote:=0A=
> Fix is to return -ENODATA error code in btrfs_read_dev_one_super()=0A=
> when BTRFS_MAGIC check fails, so that its parent open_fs_devices()=0A=
> shall free the device in the mount-thread.=0A=
=0A=
But now it doesn't only fail if the BTRFS_MAGIC check failed but also,=0A=
if the offset of the superblock doesn't match the offset for the copy.=0A=
=0A=
Sorry for not spotting this earlier.=0A=
=0A=
