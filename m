Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3415B9CAF
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 16:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiIOOMc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 10:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiIOOMa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 10:12:30 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDA3985BC
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 07:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663251149; x=1694787149;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=WHB1OxZ/HZuFNPkm/KUTBTYlnphsm51fudrl5K3FeFhxKv0ayD2DjPBW
   YWXjpK8svZRHPi92O7blyixbPEquMoTAhb714uzEVIbVN8yPE7txkClGy
   bKlDo+mu1Ii+oYhxBjlStQyEyOfeqiXcYoUVjg5gC6e01T1aBsS0v36r/
   3qNlSxCYXpTGswPQcGUGGX+AAj0HvEDHthVOzyrdOh4okO/eB4jnYslcF
   6PgVv+uU6FsfxlM+Zgmo7h8bKm+HxnTT5BE8acHqwN9pqXZDDVIP8IDBq
   6Kt8L9lsZ7sT7x+5+6z5E0HlX4MwO10WOcHvAf7wZrtbKKplsU49R8Nk0
   A==;
X-IronPort-AV: E=Sophos;i="5.93,318,1654531200"; 
   d="scan'208";a="323543524"
Received: from mail-mw2nam04lp2170.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.170])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2022 22:12:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gCZlmZFIrdwZQ2BBDYHJqy29MHHbDF9s3fGnqjPl+2rep3bFDX7EExBsw7gTupvtZvyW2uOmN06l08Bv64bVCFk4mu0w81UvhvLAyqflOdP5s/Na7TNbGJ1aELhcu2cStzKTypOZB9IjUhvnfSGwRtV2UDL+DbdTsua7UNzSzln304gaWoCOCjulTiegvj/qj0wWwT1gWQ7VcOrPaOXVKZIphpdP0OXYdjA4LFhXY1AGqefHdudp+lgkvUEcUNlA/MKq3a0t68iCKAlvPwCsn/tQ3fjYAXrBrnU6Kr2h5sjdwz2WBMNhxRgMT5fsZ+LYNTV7AlePDKqK+PkHYaLQNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=LwnNxJ5CY5JP8NUbJgf6HMX3E3kQSc058V2RprGjhkzvkXuXPDLxKk+Mjah/FnweioVpn6W3rBeeVR+l6IiCKrf375fWjv6z1hMNG9bFOYDBueaNFLSE5csLn/H3AQ3hGeyZhejzhBLc04IlsNiflrKhtCB7lIXckIUF1FdvDVLVB+AbfJdTWk8yMEFCHalK5P1lE8ULu7Pn4UcomqvaYAk2y2ZwEieGKAu5IBUdb6cloX3rwplgSuv8SHXzHtmy2HIs3KH6CuMmjV6FRfWIllCaIvF0eS9i5wAVEzTfEgJtVn6dS30yWBceUm2C7ykt3JxRQvYubdk3FS+ux7wd8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=QQioLkd3CMl4eLatf9NpBj5eMgIBBeXKkxrUwqWt2pMLl5cpDn9Zr4dAILlUsOxwVNCJ7AXn0uAtsqgFoy4fPy1cxloENBtqtiZ59ydC/NLtlVxAXZgnOTdrYOHjxmMww2fygYBt5c1zX4Eqx59LkwNFmihP0JNPzIEEyzsicb4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN8PR04MB5539.namprd04.prod.outlook.com (2603:10b6:408:4d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Thu, 15 Sep
 2022 14:12:23 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%8]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 14:12:22 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 03/17] btrfs: remove BTRFS_IOPRIO_READA
Thread-Topic: [PATCH 03/17] btrfs: remove BTRFS_IOPRIO_READA
Thread-Index: AQHYyEuvMbq5h86Cv0+OBvXOYPj2tQ==
Date:   Thu, 15 Sep 2022 14:12:22 +0000
Message-ID: <PH0PR04MB741665031A8876AC0B15DEC29B499@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1663167823.git.josef@toxicpanda.com>
 <2ffc1a38bf1e342d2b1a44105b00bf3c8b57686c.1663167823.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN8PR04MB5539:EE_
x-ms-office365-filtering-correlation-id: 6ffdc948-ab07-4d9a-8091-08da97244f2a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tcrLpfG9QZI7BuU7rTxwU7I7CRHq7iUXpU42cmCPzPF324l4eljE6U0Ng+ySR7OnhZsZUZ5qimoI22JI5nw50+jNzP5El5vF9GWDDFG20ThYeGMEwZDeewpza3JOdm95WvGCOeCVdu+p3JHmKXy3YZ5c3kCSfNwdZsPhdGEN2bPtTenBgPs6Z5vuEESrKQyEb0cvfsnn059OjJenMc0JQ1vIR5KDZvufmDzPs/g4dVOONxCRBgneZvJB3eqovtFPkfr1kAhnl7S75MsrImzYqixS5id+oiwkatSN00vaS69oupEg4PPzmLVdwrUcd2eaOhbo0VELFRa/j4U5UmqNoayoe3lAxre0NAuIRbpJEN1LzboxyGMJgEOJLVpC5VvabwRlVSaCV1HxEiCLxYziCNFcodM4Ge/pi/gtytXtQs9eZhNEADkzCh1F2w+Yx4uwgwBNHWZJ8nTECTehhs3Cj2vWU9qcgxluGCBCsxpWfIyysDt5m9G2WbyrSjemejG46HxzvfTkKQY+G8IGm45ZWDKZh4OIrV9HlzKhKLT1NRzbHfcwadJVHpU319K/hJy0klvxwfYxaow6kUDZ2c0c/+SqaPp3hiJg0BL4rarmDzSTpN4GFroAJvQgclr91EWJYXB7ySRBNPTO7ZqEOd+bXgoX+lWCWwtBxlbxe9BkW1FgLjZrd+/iaMRrHYaM3nKmDe3JkrqJL+hOB1wAwC73qTWjwSnOd0m/UJCqZkR9tgXnD3HS7rRXFIP+ImouS/3WqEyktlQtuu0pC2APE2uuFQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(346002)(39860400002)(376002)(396003)(451199015)(91956017)(55016003)(38070700005)(558084003)(82960400001)(38100700002)(122000001)(86362001)(2906002)(19618925003)(186003)(8676002)(478600001)(66946007)(52536014)(8936002)(33656002)(5660300002)(66556008)(76116006)(66446008)(64756008)(66476007)(7696005)(41300700001)(6506007)(316002)(110136005)(71200400001)(4270600006)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?g61Pi4rEm9hm6YohEbHUY30e094jKm+g6YOIbWLOBI7syg6eMrqmKMGtLLcQ?=
 =?us-ascii?Q?w4ZtZssohePpeWuznIBd7FmPAocj428DqmYihuhw+wC9tP0qYLbcAstxbinK?=
 =?us-ascii?Q?cakifDH9YGZh3FAnAGws0M2WTu7CNvEWutNxPP0KO8T40G8P+iAGr8zoeHHA?=
 =?us-ascii?Q?UlMxV1QEfLb8UvJncmY+/ugFQqot/XUqw3LqfWMG+FzBQmCbonOpsUyrI2Vb?=
 =?us-ascii?Q?JILq146OG8r+wJGlvx9sXLPZDUVDOC1BQEPVQ7PjIkpW1iGJbQdByToeUhRJ?=
 =?us-ascii?Q?QvWBvSWSF6/JK/VuHy55W68nYV+M5d3QYaMpEqCh28f3Qys/HEcW/KmXdJea?=
 =?us-ascii?Q?lyxeemdy8n72AHpXMgcwg0WIVVTE02RjB4gI8SFvSbZrfeJ11A2g2T2qJhnm?=
 =?us-ascii?Q?oyn+9Yf7QtA5t8Nx6Yh4QlNOwp7dDkVgfmM1zz+UYP4VJOp5MeJP0clqHpu0?=
 =?us-ascii?Q?2yna3bT9jB66mSWzz34n0FL30IyMz8h+2VVuQSVL5JpbdcBlcLG2JZXnYUEw?=
 =?us-ascii?Q?cw3+kNPvm+2J4JX60QDzGyAlZjZ/6ai1Qyxd+Jf7sFliNacV+Xxe1I08g682?=
 =?us-ascii?Q?vwchP7VWQualAFn99rDqg4ciNgSf7Thkba/kikfiFi7MGU7Ihg/3XUrT7z06?=
 =?us-ascii?Q?OF9yd0Ht1ASqydKprVNw9QXFV1XvwHWD29la+8v1D6Ff88U+MO5HNAAQuZc2?=
 =?us-ascii?Q?Cb1NpZf5P8+f3ZVejUr6UwTGl+t7etbrzV/+a0PoF2rUemq/7oAkED+qaBk6?=
 =?us-ascii?Q?BrMwaoiKqalk+Urz+gjy917hMN33Sn1/HktWsWXea2l7i5sy5uhoAnOIqVw/?=
 =?us-ascii?Q?SpZ/MUel9ll035AFSDY/Hyf4rSeARBgqCMKhY4VX1WxYAsjq6w+xKp5+f3cw?=
 =?us-ascii?Q?t6ZDZrSpmjf6UofWcwS42XmfGnqP7iqbcH7dzThDRvFM8yHontG6d/t8UNdt?=
 =?us-ascii?Q?vf2v30xTbpYQcn6/QhhpFAKAiWvqAiyM8VAq6ROtt+VsqXd0ZQBqS/6/CkPW?=
 =?us-ascii?Q?pXQ5J+SDAC0dyo8cyvW2yQBjHv27ahQ3ksRT1eKei0WXxP+FeRBhucNTOPCJ?=
 =?us-ascii?Q?QEcKZPL6OR40+9Q8bS/jcbSLESOY5wHuzNnTnpFQxrDkd6RagxM1Myl3iMd+?=
 =?us-ascii?Q?MCW21B9v5LkPxKuOYTqu0a/zSSGNYaVu08Kvce4cOE5OozwvWzloKTOQJoBV?=
 =?us-ascii?Q?SvTQOj7SEF42nFkIP2WCT08uaoeukDYDpLATJ2kN6s0t7n2a38dFGNCZKGMK?=
 =?us-ascii?Q?OIOzOK9KrYp7ZMGVR2GuelAIa74arLE0vQ3JA9t3PjC/AuRWQ3Wlcyhn6JM4?=
 =?us-ascii?Q?QKVYIZ10b4XRUC11xkl5knN1pN/XmUFHBuQqG506UMu489hUbaJdLRpFpeUj?=
 =?us-ascii?Q?6kil5WPp42rjC2inIhexl9LwoxcZBM95+qxMneW9kG7+QYTluuwgR54Q1oud?=
 =?us-ascii?Q?wSEkEPqfL+OVZlG00PAyVozxBCYMTjXLgYQpM47lKWeKfZtqc9vjlO8LOqIY?=
 =?us-ascii?Q?e/8CW46+U/r6NtIpxQWOUA1+rQnAvRsA7ywVS7b+D2vAeoeZjizC3J91uEh7?=
 =?us-ascii?Q?57wkz+otdz8yWViogZ99r6XISdyEL13uJJBpeqTw47DNFxiIlwCEM6Rt1BZr?=
 =?us-ascii?Q?W9cBFJHOF6pCFuQUhYyccMpo08042RKqQOwIlLrg+CzNU8at9Gno54NiqmfV?=
 =?us-ascii?Q?G+RvmfntQuwY8yB/GH4daeqW52U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ffdc948-ab07-4d9a-8091-08da97244f2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2022 14:12:22.8523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BiCrdOu6/0Jn1PJ1ZN5rSTn99MM6j1gEQSZ/JY6SxxPXF0zk9QEvtZ9B1zRYzE9xaS+hRkJDfs3D7bnccOqx3tMRKKenyu3TeSLV10jNrUg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5539
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
