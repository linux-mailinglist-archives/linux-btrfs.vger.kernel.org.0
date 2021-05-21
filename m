Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 734CC38C0CC
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 May 2021 09:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234464AbhEUHfV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 May 2021 03:35:21 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:24720 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbhEUHfU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 03:35:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621582437; x=1653118437;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=UuETIs386trWwkQ9XF+co30G9zNPuxZrwWQTjtseFYpEJwOXFrfKnXxK
   7PPH2eFaTpG5aOGQBzPo3Rn9VXWtnJ0Dga43u15kjStwisEQ1mAh15lB1
   QFzz0LRl+LUzwBZojfN476ceBosoh/fTrCb5/XuJpUMM9QG6pLQ4mUnmr
   jbFZfAZAE/JvVzB67ySBtNmTnThwGq+UM9F895AS9bZBiqx4rRqDugEY0
   f2GYjfBcPV/rxvESkFxQ4/2QvXpbBc5t9Of7CPrT2V/pLPkuCU1EXXUaM
   DLVdw03WLD9B35mF3pK+fZupljgeub/Qnm45myeOAt03MwSFWHRTMEkAj
   A==;
IronPort-SDR: a6iOJQK+DV4TtzNOoKyBNxANa3tAh63QWDBseJ57HVHCbnvx1gcLJLZVGY7GvNrC82R2lenoSr
 cRipLILkHlBHW7mhjP7PKl7WIVRoOeFzh54wfKrx+9CxzBxBsqze6x+cmzNJw0V1JQQ92758Zx
 Q7Se/BdTSrxJMT/2lRrzFwODDbRvq5DjJsBMMV+mCchom9YBlqYqkrrAYacK35K6FrQqqgI1OZ
 M1aKAdQqszSvbw/3W9PSWX2gftUKjCuK7sHrqcr7lM+bwWQMQlghsF1ag4yj95+1BTjXfhRbHR
 RnA=
X-IronPort-AV: E=Sophos;i="5.82,313,1613404800"; 
   d="scan'208";a="280229952"
Received: from mail-bn7nam10lp2103.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.103])
  by ob1.hgst.iphmx.com with ESMTP; 21 May 2021 15:33:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=laOnaSQbr32xhUeo7lMERgId/GW6mTzUIvXCwkbXqi2XqObs+CsmrIPI5KXM2e7JaGhM8BEKgvnbrxVTDepzDV6Uhs0p4l8mJgUUcJ5h9S+VZtq1SwnrTTjrMdb9eZhyKZkw9VIYE3betM4hARTs6D2XIjnjtSci+EeZHDWYbFXgLT3uVEmGI7q8ivRF52qY5tUgO5OLmHY1laQztkL5Lp1Ul6bQuXictn+cpePe5zAVUxhQaM6dQP9l8+UVnbBU0LMoNjHrgjqGCdzFi/J9Bxvlsjye6KqcaTNUb5t35MnBc22Vu9nWwy8i/EYOLGOWDjH7lsQjG5N5R7IZ9nMg3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=GtDGxrdJXYJM/OYH9gvdm0pT7/NKU1JOJFcr/vHdiuhRuqx+sOf3Efpm3YwRAcyyA+2dLY2vq7bMXkpHy/46XxfbZnQXeWYlRmH/q9w/4Jf4DtzR3zH5fejcUCfdNYZNgXbT8YQXddEMtR9dCIOqmX0jtv/CAztYDi/AzxJh7OdUlzxhDqBdUsjDn9fj6mKhj8JzbmvZpXbeERtBBM2zXHy6V4FwMzNWLcKprVEtxM//7pZvX1Ns7OOv6sbJeeLxf9JMUtaIB+DlRxl22kIsO1+9ge94oafWg45hRRRAXCBBzdz3vEE3/WRZMLu3L56NR9cL/hVwDqWyUXRm0e3Jqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=oSuyMIKsylms8w0enz2tlsekuLbl3zT/m8Ae+Hb0VB0LONoMLYj3z3rr7Q24R6CBNg3xsoqsy/2bFZz7f19EDjC7tfbNpmquYKZsVwLltvNvNqqfauX4nw3FL2rP+2cZU5+5mORc1UqE27KydhO/nzakN6tnjXmGg/E+fpFAFkw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7447.namprd04.prod.outlook.com (2603:10b6:510:1f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Fri, 21 May
 2021 07:33:56 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4129.033; Fri, 21 May 2021
 07:33:56 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH v2] btrfs: change handle_fs_error in recover_log_trees to
 aborts
Thread-Topic: [PATCH v2] btrfs: change handle_fs_error in recover_log_trees to
 aborts
Thread-Index: AQHXTYbg2qsSDn3hWUWOoeb3OMvVQQ==
Date:   Fri, 21 May 2021 07:33:56 +0000
Message-ID: <PH0PR04MB7416790045AA0CD04989BC259B299@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <0bc5200e1d20ddcad6d5a858cf00272197b3df67.1621521913.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:152f:cc01:f8bd:921e:9aa5:6d21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0616a247-3108-46af-8a91-08d91c2aca90
x-ms-traffictypediagnostic: PH0PR04MB7447:
x-microsoft-antispam-prvs: <PH0PR04MB7447A11818B3354CECB7C5F89B299@PH0PR04MB7447.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N5SiZRweQAmKUZvMKg/00dsF43ZaN7Cru6ca/MPgYMKei993H5fACPthc/RhTs3ZloDyS/mJXmYTzSVbUdG+ZaN0p8ZbU0vSjLMpPHg4g6U+6LXQhEddYfn77JzupOzKbWiSxo2nbIXb6ZPhatCb8MNn6ZbNiC3El7iYztGCXHMBBDqo3umRRKOetM1qFeIWb3NARNR4GuUcfE1S0DzYlMzO5/H6CGbFuQVKaojfOmUIDE7piUVgvxOd6tIAFwV9K9F94cVoCINx3czxflbmxMdBtzJnk02/ke9tAhM09re3pzpnFaA7VWGwMMVLhfkwfGRv8oagdefVjqAWRSJsAksvG4Jzo0fDnMXFgNT/nF2MTJ4d59Pw6N4JipThS/wqcwJSMTfo3Yo/W56esSoJRJPDtUdxVKR8mCiS1I62yek4JosMZaCmYNHYeZ2CwYzYzfrzphpMyr3tPawsmEo1Cz1eGCNgLKssYlnLzMqMY/CG8j9qwoOtR7q0bJd536h+NDfKeUXWkliOL7rMhf8fkFuttCmGpxdWZb+RX8k8ipEX92I9xL25bJxEHvqi/ZtMJIoEpM3hdHXY8t+gNtY162cAgt/J6u/YK5NI6VM43Uc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(55016002)(38100700002)(2906002)(122000001)(66476007)(558084003)(76116006)(91956017)(478600001)(64756008)(66446008)(66556008)(110136005)(186003)(52536014)(66946007)(19618925003)(9686003)(6506007)(8936002)(8676002)(71200400001)(7696005)(316002)(4270600006)(86362001)(33656002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?zUlTor5p18xUC38Fk0ljlGr+lMs31ZscC96u3KuJhYWRiFtCYrqnSv6zbYMz?=
 =?us-ascii?Q?i+tTbqWuS0uZPwczL63MpR4zfzVjnZNflEFFBErrWmFYxtzX8MHis3kaO89S?=
 =?us-ascii?Q?2CYrVTaJ9HdhW0tnTzRnjBWb1blQVW8zTfwcQ6YuaXplWZEdAHRgue99L6Wv?=
 =?us-ascii?Q?sXsanehL7OrYPiIaTdiXlXLkk8BE/uXOrSG4xZ3cnp8zC3AM8pgwDqp6ynY8?=
 =?us-ascii?Q?l7lSMFUVCnAXud2gf5oyKl7rf4aXWyCiVoM7wBFVXwkHOj+7dqIQJLYIPQOl?=
 =?us-ascii?Q?dcIWbJ3NShxXCyT7dzslUP/hI2+xn8OAlq+PxsFhezbQUsITxWtiS4OIe3Q9?=
 =?us-ascii?Q?+uCQ3Z+zfcehnVcyiK+sANs25bZ5rd6ir60CEpMIlRQeSFDXfaQIJ12qE6TV?=
 =?us-ascii?Q?g1Qe7HZCTMyGfYQZFKGVQqaQdfWYaf9hN8GGrpUPvNJXO1iFV/2Ts6YVqjR+?=
 =?us-ascii?Q?BE4dhdf+pMMIXn/226v3sxD6ZhLOr2XseHd84XnMJ9JGbQUTvX0LNbTIQuxc?=
 =?us-ascii?Q?9XRX1914co6OucaqvXRkj2IkCnUEPRE7TKEpw/sMMpGA/1BUFZJCDYYPZ+mH?=
 =?us-ascii?Q?C7JpLAZIO9Rv3sOx0zI2oIobzhUD37E/D7Gseyo5sWRrC3xxiOjm9AhzNN/f?=
 =?us-ascii?Q?jWn05lFx1V49D8+NvhYk1el5+L4okeGRrwf6344HI9gZfD6efFkGrBDdLd4N?=
 =?us-ascii?Q?x52oPeCv1vl3t6Mi2cfdrb8MRw8cOqz+seWm7aH89jh82NTV6VDYTEIgLvz+?=
 =?us-ascii?Q?WdDDfQ7cWI6E9Dza2kVcW0Y5YTp2wtDBN/hc1iHhb/qlDR4HwMRRMNsmArs8?=
 =?us-ascii?Q?XPlxghOpctC+GFozjkB/Wtb+hd5XflIFU2W26vtyPFmj27IOkRJSge6O0QKn?=
 =?us-ascii?Q?SVWkc3uYRfb7EhpBlmT/fJ0A0DJo1C7VI7iAGhtQ3dNfX8/8Vry1jaYX5jOM?=
 =?us-ascii?Q?va68ZS3vB0q9JL89qR90FM1PF48QljZSL8Ib8s7Kls2Y7DePjR6aJc7PACeb?=
 =?us-ascii?Q?pWvJnWt0GIv2TV1dVUX9RqSrOAPhRcyB3Y1SeuV49g0Wh/9NEgGwkFZWl9h3?=
 =?us-ascii?Q?GF92u6bDnXwFOyX0c1ZrGji1CigFrWg9fO9kxFCN50y2scJweKPgJ0Mugr7l?=
 =?us-ascii?Q?uMY+eRwz6Qnm5GUPs/1dYkxXkl0xk0/Oi/qjgd9Mq5fpHJpL7PY1QNe3QjKX?=
 =?us-ascii?Q?02SIX1NcCiZJhxR97IFBLujX2tOzigbXH/+k3uCkMbpwOb+OZupa8xAgqow6?=
 =?us-ascii?Q?BF1bUSr4zWoJ5b7SI8BoEeEfcWDW4vwRVvtD1Xu+REnTgYrhY6/VuJFef4Wq?=
 =?us-ascii?Q?fqiL+RXk1AO05zY3SAzY8Q3LydhmLXvtWlwX+eG+emgpOLe+VI3L+OVWh2Ti?=
 =?us-ascii?Q?bZoXESoHQA2Rmph5cWQKotQNIhAGwn6RLfM9EUOe5lEwmi9mRg=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0616a247-3108-46af-8a91-08d91c2aca90
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2021 07:33:56.0577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i5hiOX9QTtMChw2BVowesHbjBy0Rv4QLYb58Ik5RhzBdoRMzUa8YaUsV7hgGUcgMyOrLlHwhJnDExoHQStte95Q8XCvzYNSYxZtk8lvFShE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7447
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
