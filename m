Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94B7F34C62A
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Mar 2021 10:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbhC2IFf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Mar 2021 04:05:35 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:16728 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbhC2IEk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Mar 2021 04:04:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1617005080; x=1648541080;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=KQKEJhwwea0BESaJ1kZlLUMje4ZQh1VEsAO9i/Fwf1jvkxzvlf0Cazkd
   PLYPtE4dJNiHwjUmu6wwh+yG1ELOocp1QJSSP49ogHUCE2TC4GaklGa9L
   /KET/nZ5i8kfolc7SC/yBc637Rc4UgjfMxqU1rCQwRhoMam3fT9NOgaez
   BzB/IrPwJxFCHLmNXyyJjRK6hp1QMOp1lYqqtgB1MaibMg7vYbJMwORii
   n1ZjEmnZAydRbkTwOpuM8GwwgntadCTLf5nyaKUBYBdP6g6D4M2T337bc
   ghdRv7YtVeQwIhOs4v9hCJcHthyJc1os37vkkXU9aZpKUoBRfh+TAvJ6F
   Q==;
IronPort-SDR: rkCVVmKsgkLMBAlYS8onT0KbJwkxeBEIdBVv9Dc6UK48rdxK+3IBRCL5zU0ehkulQ+RAYnywZ0
 w/2ycaYa3fwPTNIyiIr22qoo1yEz9n2iAlMzMcc2xHoMVFXTPZA9Zrkzo6alZzkGYGys2gKsLu
 Hy7IF4B0F2eNLzzOUZ4U4lGhzaeQa/P9cyhw24JOPx46DX4NA/dot31jOGULVT/bKXnkT8amIV
 1TJrsegRoKgYx0/3Ny74IQWO1vWuYeQWadP2Q34ON+WV4z/BrUcUukGPT5lIMFaCeH8wTw62Jw
 YSU=
X-IronPort-AV: E=Sophos;i="5.81,287,1610380800"; 
   d="scan'208";a="167705589"
Received: from mail-sn1nam04lp2053.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.53])
  by ob1.hgst.iphmx.com with ESMTP; 29 Mar 2021 16:04:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b5bELerr25oL74kcgxXdaNdkj0ce6DmgQtWwf3b/u7JBpgnFeQLU+8aNWwnYpi2zSRmyD3fu8Wdc7W7wFn91ckwu7gWKtmuLTc402LZgrnKKjYnJTFhVpYY0R/JdB+gci2EnHxfpX1vafQJYiXoxdEqPOu0ThNwlmY6GvspV0IhTj63ujtwN2nmKhXhP1JXDsd6n0+mICleSyjthvr6VNxtAHPk+V3R8gsJcjkzwIMv7WnUF5dh8NjSCCGonuL67gjQJwfCXvLLqZQ9BIghbsMYKSJguyHk7AN3PNnDCnn8WJ0s42hUrYflAQE8y6zxiNX8BExXPo2Wb10JsvTV3uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=bfe7MktpGbw9YskQw8586iJh/VhnEaDyTfjQaNd5ipKkHOWCkyfmHH4a0FRLJnWRLlW0ZAyBJB4AFfsn3afjaoABCIpB7z7HtiHy3b0jVARKueW51h4qCrWCOTSE8CNtQGg9J6NVSIDUc8KIC+W4YOZwVYkFU2d/imV30vQhsOUCzMgNroQ+Qjm5eJicGjWMKtccmSJwfob6Dpxz2GODyUOH+bWBb6cRv1aQe6U6NTnrzj7P0lx6280qkEaX/hGQ/l8PRqWaI+IK/01eyjMOIPSAaLv26ivm0gxjcMBEUdosQTHaS8mFSWs3gWNKs6HSAJIOQNEsYFjt/enUk6LpFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=hp5K+yc4up2+LHTIaWg6ZJoYG+U5hVEK4mz3I+TNITr5QpP9rFOzqcSuOSsJPz3FUNTpRuI095c/pk+4sKXAYCuZNDUwcVTYYcXrupJBMGjIZIJkqTHd2S0hzWSHM5ghXPZqDcx0n2eBsJPFreMuGvt8lqrW6Avy0y7mo06O3/E=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by SN6PR04MB4685.namprd04.prod.outlook.com (2603:10b6:805:b1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.31; Mon, 29 Mar
 2021 08:04:33 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::d5c:2f7d:eadc:f630]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::d5c:2f7d:eadc:f630%6]) with mapi id 15.20.3955.033; Mon, 29 Mar 2021
 08:04:33 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>
CC:     Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: zoned: move log tree node allocation out of
 log_root_tree->log_mutex
Thread-Topic: [PATCH] btrfs: zoned: move log tree node allocation out of
 log_root_tree->log_mutex
Thread-Index: AQHXILk/iKjXDTG3jkytfsTqAL+3LQ==
Date:   Mon, 29 Mar 2021 08:04:33 +0000
Message-ID: <SA0PR04MB7418061861C66E1FB817EEA19B7E9@SA0PR04MB7418.namprd04.prod.outlook.com>
References: <984c070461f31182e87d1b4f27c4565088a31b40.1616595693.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [62.216.205.220]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 18527806-604e-4465-a82a-08d8f28949cf
x-ms-traffictypediagnostic: SN6PR04MB4685:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB468516DBA51186988C159D7B9B7E9@SN6PR04MB4685.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ySdybs7MTWEUMXNhya+yZeV5xtLHHvUVl0hMsfzo+dVzSqrh0c9BmlaCb/eaRSLlQ1RXiPSinxOIspmkjKKaxxXY3HhNAKLdnjfDFuz1AXhfRYEROe46RQlpqfXCb/jyK31zoXKn++U8JxLlHn2BOUMdtRzqlLTMNx34s4LJY4e+cXml4fxU0VQ+DcJLivfKszUOFq2KlF2FoJDMB8VmgqdPiVmwxRGKlUZ4382brT5Bq6BK4zwz/Sc7BWaal5qDe9moVxFS47/wZmXgAVlRCPAIjBrlCKQQP4ZVG0ffBpDw9cuhvIBf+XUtMKi4B6rBcYUJEoRCJ5R2jx02NlS/FDRX+duUyt/02mXjuLECm687EE7FfYfgre0qWs9bjGxfRsQo0qHX+4fRnNT4QaQFjmf1Qh46ZVcx0W91O3L4dClbJfAJxl4WrKidhNIf3UpZymsTqOP6LwxcS9ormWpgaP3SG1bk9s781dVNEXJF9JaJ93GBD3YTliQY74m8WlgYISMM2lqgczx7+Lfa+30Wx4UCqWRW/n7S9gD19vIAp/vdO4SiPwGe2/QnwO1J+ZXjE1d3gIRlpihfA1xJAiu8ikodl4zP618kxcCfy83UiQbmFlbxklSWYNg6irDsA0a/S8x35pbOAOEUU2vaU/8jg+ntVxIbq56IKA9X6Tb47nc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(376002)(39860400002)(396003)(346002)(66446008)(558084003)(64756008)(6506007)(66556008)(316002)(66476007)(66946007)(33656002)(4326008)(52536014)(5660300002)(38100700001)(76116006)(8676002)(4270600006)(478600001)(19618925003)(86362001)(9686003)(55016002)(2906002)(7696005)(8936002)(26005)(71200400001)(91956017)(110136005)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?UMM0HfVj/GBz9BBHla/8a3HSxn4xFCE4h9Xl4d96nVfNXCL6ph1MXB4xB/u3?=
 =?us-ascii?Q?fl0wZ9K5KzPdbQWsrqqhk47EC8xpCNU019qCyHion5+sMp+3zB+RckPB90B7?=
 =?us-ascii?Q?wKZ6GuxGe5wMceSwy3spMj+USK9FqEeghucqlVQNK3AnwouaxM1xJo0WvdC2?=
 =?us-ascii?Q?E6ZFfn+/RyH6fiEf9mcCPbnTosy03fv6iE4f+O0E/F5qRX+2chxgVQ7LEoWR?=
 =?us-ascii?Q?wTpS4yW98P0IOHWDWFpJU5akvHCjeUjEFjjZR6DBjQ/Kfkcub5Cl9lDWiCFq?=
 =?us-ascii?Q?s3Ek3+Lf4Uvn5Xe0S16Ub7FtT7sqicpPVWklz0Bn07h5kZM/YzFhhBbLUayV?=
 =?us-ascii?Q?wj91yiTFQGTH4oB9aGh2xnuEVcEDHUpu/++9RAFs8UAAcj1okb8p2+0rt9l8?=
 =?us-ascii?Q?Ojt8nI3AEVaUsrgH4crpC2pwSS88YTlvagYhoFa/onYIeGCNspj8fsXfEaQq?=
 =?us-ascii?Q?pK7FlCRxBKKbXI74pe8Ku3Ntnc6R6ySfIac26Eb/HRuwf8NcoixVALFFx5oY?=
 =?us-ascii?Q?JwUwaMrc1vgHHJY1Wz1lxKlRbvNTuObx0POSSuYKeuqnZlaZ/nI8m65PStnj?=
 =?us-ascii?Q?3TTeYTevBtRnMmkXRuR4RXt6pUkiKdBPROWfFRJvXLdVD35BuEH6iHPbOExb?=
 =?us-ascii?Q?W5sdmwNtsPdlIQp6t/hqlXuAiF5Syb1DwJgbFrfO57M9tfHg8Kyv8Vsn4Woy?=
 =?us-ascii?Q?2j2+iuEgi7M1QIB1N2JsxskfFFrU+xH87tbJydQhfYqhbRjk0pET/yLe07v8?=
 =?us-ascii?Q?aGW4psb7u1TcD3rXY9SVQpb8uMOVWH4iZdEgN9hxulXuYjOGfFkJ5dfE/Ynf?=
 =?us-ascii?Q?tRXyDfjn5CTrHmrmICdCUw7RHq2QYVue+APbEPyCXlHY3zpUqTXuuOHYZlZT?=
 =?us-ascii?Q?XFPaTLFLkc0qPAZ8ODA0zmovr2h7wcaGnrICFPaBoCKFGN+VqzhPlMG36JLE?=
 =?us-ascii?Q?YUHy+JnFdRxhiCeQcQNoC2lUVE0KI0WotzCKd3vs8Llw7cgPQDtxtmGLZGUA?=
 =?us-ascii?Q?RphA/w5NcJqlUiC7xCpT4ZeuvHSSd5b913ExZ4IdJg0oVb87aemg93/tTqFG?=
 =?us-ascii?Q?WpTbE3PBUEDhyfBbiM5Sj/6BCOZy8cOGWQsIqTrhoYqW/6tCpJnLgHLBuYZ3?=
 =?us-ascii?Q?SBZGspVitlbmJqDia9AnJj4bllJ0ElYmJ3WXH7vqhPVWhx7x24Rhln5SYN50?=
 =?us-ascii?Q?JiIr2jz+0GccnXQn7aaBKR3PR33i8GoA4R2HfnVwk2IdLYRm3pD35L4Sq6gs?=
 =?us-ascii?Q?F5hck7cqyFrSQsi/GHpxEXzCRHAkmvixYQjFD7tJa4DGsOn9G4offUehpTrU?=
 =?us-ascii?Q?tBBjUDKGQAO1SdE9IYT8N3zeXqGxZtYjK6wLd6Z7HtC1Vw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18527806-604e-4465-a82a-08d8f28949cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2021 08:04:33.3790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mQOqKwVJZLeHVhnVZ6ltIZZMZqzHyp2j7hRXDtDseb3d8R30VOB/ac45Pajg6pDQgiZ2jUZFZDeSUzZKlOuF+Sp4Y5TAlkuWk3b0D+UTacU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4685
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
