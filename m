Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A33D5745D4
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Jul 2022 09:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236815AbiGNHX1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Jul 2022 03:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236299AbiGNHXZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Jul 2022 03:23:25 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2997A2F39A
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Jul 2022 00:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657783405; x=1689319405;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=oD0HypD9VS65hylRD+4eaQB4Wwr7OmIB3ChvyIf3IGmvgXT5weVsKPyD
   33sJoW3XNmeAOR5KwHhTiNe2QCyh/THnB97nz/jrRLY4N4YlYJountEb3
   v+P6Ofw863AemUx7vXmBQciYtNAC06FHTQdGrtfjGhJ69C/t9qFUF+c+h
   OQjK/PJlQUkUx4/eo+12uYXwn41bMDVjF5mctSzT9i0aFlER5fhj6k5HW
   z+Ck42Cd+pa13m5AxYSZkSgoq/xn3Kcq4Hg3bZ2UtCaRc9L5G68oOy8cd
   7GaI0wCFl7aVnar/WiHEc+5vlAsOxT97cE998uxhDdKvcGl/tpKWMjvB2
   A==;
X-IronPort-AV: E=Sophos;i="5.92,269,1650902400"; 
   d="scan'208";a="317832267"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jul 2022 15:23:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SmdnWKrrvjdZMhHve7xdJk0OT8Pi3M8v0givK+uvn9/wEKr/dtL9DxIP1Sf/+0zP1RltAEDr/5oKPHPuj5oWLF+5F9db0Y2lC2nR4xEN5CgIspLr8INBQvP0/nrt83DdMEGRVVHHaY51SwBgtTHU2+zIwfiC8uSdWWU75bN1n2SxwM9Ynk3owfCVGWtoNvhnvPznBLAYc9NcSkD1xgFqDt1qt4WCiDsBIv3ijyxFaP1qdhTRmzFJgY6tT8MC6ol1VYuqE5yfH7gN7uqtg7fzCXSoFl09Y5O/0iO8oIwZh+BpdoVaQ7YkylQrBVeG18sPRKqfz5KlO1ndTOti3HeaOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=iDzgbb8RzswBKGovvcT/k0TokdeHzauNl1U7m4CYPaAfDhz/Tm4kxelUK2Eqblu1DWrFs9T0V6dICRpLPbQBZGPJG942DHbrtalqDTEDXstoLaPZTbSQefeaAYWlTghfZ47GrakiHlVTad0Si6Gbg50bBmT39tbCuBFGRHzo+OpZYaixW4CEEEUOg7YtnxELZSJIi3J84daPySDaQc6cCjvwlDo1MInFLCjYO+O1WhviusT1h5GwKe9IXwVLZil29tG/H2XALdOT0S3Qo7SFoPDDekMwMj3IUXNB5IPrsT8rSR8GtYS7HBL9dzAo9fnBlpnu5Z0KQKyr9A2Pr0N/SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=AUlmlgUYI0W44oae1mKxISIA5Etz2Stn3OzhF7RrjFbQWtx3+gYAlwoCNbGhkOmim3nu58QAseAoijLJjvFZAb8d1Hk+RX+FpZlcHiI0Z/j3s+qezvFxnM47kbjIaXAf8D109ukB3FP+ml2tUNxFMWLHZAaYBiAcLA0Q2g6Qp4s=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Thu, 14 Jul
 2022 07:23:22 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ccb9:68a4:d8c4:89f5]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ccb9:68a4:d8c4:89f5%7]) with mapi id 15.20.5438.014; Thu, 14 Jul 2022
 07:23:22 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 3/5] btrfs: remove block_group->lock protection for
 TO_COPY
Thread-Topic: [PATCH 3/5] btrfs: remove block_group->lock protection for
 TO_COPY
Thread-Index: AQHYlxl7O4UZEYW710+wmvkMo2jX9g==
Date:   Thu, 14 Jul 2022 07:23:22 +0000
Message-ID: <PH0PR04MB7416E3EC4697566ACCAA26019B889@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1657758678.git.josef@toxicpanda.com>
 <7274bb25f458795173dabe6a3c84363a5d100450.1657758678.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 270b175c-7094-46d7-70e5-08da6569bbee
x-ms-traffictypediagnostic: CH2PR04MB6522:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mqvLY5B/mz9mXsuqlj68WpCt93lXvtWdD2aAkUzm1GyTpZ+T1o06MZYX/wsz8x4yRShFiGtowdA2daYYxjGjdaGMJljzIY04GvpbDLj6Mvw0bs3FbMlynpGAMtN4oJVYmfBqfWyivDEKb2sUlS/HeSVlthg61zzMd0u2kpVM78JNbty7iz2C++0MOytkWt6k5dt8idjbySIMSydYCo1gYAaf5PlRlkWpjlwqGFOnYt9Ogjy/UQwhz0gR7q5re3Ce7vyJFKIKiRGAOnxpbLqiddL3kjRI44fIEd8aLqk2mQ3dPyXZrxoxjTxMJIcjpo7yTK+/RXRMQGcMSFGGg5bN4mkx4z9bJAEJQIvc2ns2UYqUrRN7GhvRWPzCHewdAnI0VbpY3AVhi3EIGPFwBksZtMgJA8QnSVlVwhuDcAiCAw3Y+sHxDxzGoatwfDwfXMt4u8YstcWVo+I6PcpynFCubBZ0uqB/4W5IeEmcHB+HvpLNlEOACstYxWqYwK9rC91ZGj0YvGo5iMqr4xmXUkgLDOSQBm3nAEVmqpkc+9EV+4SLGW5X+rdioouRq/uof4ReGV13Lr9275Ksv5+yAZcSvLOsYncvTHoPYGjO9X+Ao2Mf15TmfP3GqKjgrs5E06sE5R4Igv2hGJjOd7pZ8sb6EFpfqbLjHNF09Izpy871W1DoRgoB3eqiAcfTJRW1J31d+C3T/ixGWe8GX4IM6OI3gNBcY86yR0tP85FCYtgp0MAa50FPqPJ8NCprK9WP8yYDEYu7vuq0awi+PbgGk5lKTtwK7VI1J+QC5NCuGmz/g7TBZsw1cPMibGtN0sVgGc+l
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(366004)(346002)(136003)(376002)(33656002)(38070700005)(82960400001)(66446008)(186003)(8936002)(86362001)(122000001)(38100700002)(5660300002)(52536014)(558084003)(19618925003)(55016003)(64756008)(66556008)(478600001)(41300700001)(2906002)(66946007)(4270600006)(316002)(26005)(91956017)(76116006)(66476007)(6506007)(8676002)(110136005)(71200400001)(7696005)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ISV0NZZUoY/3A4I6goR4nbEAekIqo+q5QW25LFFQxU7eV3OpKX6GoIdG883W?=
 =?us-ascii?Q?xk6NE02FomsJR5lXjQ7mfDeBw3jSYYMJgOlHaPSIdk0khDY7Ji+EX9mz4sIC?=
 =?us-ascii?Q?QjKNwigRX06iJVqisDTWQl6FypOvVEr2dqhFLhK2lkIakEcaZx2ecem6EeXt?=
 =?us-ascii?Q?XKVnn1pAzxMRs/JDMIQ5Q1cRisj9GurEboBhT5PS14kZ9nHZZ1odZ/Fz1b6F?=
 =?us-ascii?Q?oKt540Cf7gXBs13NWKYpwBUhB9b6R62bncBkyc5QNIFi2WqElUsyQaZ0Byrg?=
 =?us-ascii?Q?h8uwpN+ZZMSkRS+3j5gWnq5z//EDDQ3f/CoxgbHEOCbO/HAAeZt3RquwU+aZ?=
 =?us-ascii?Q?lMxpM+N3fxsGrUBDTXa1U/xbE5yOnUVOSqPhlW2psNw5vEyBXwv/gCXm8kql?=
 =?us-ascii?Q?Mf+yH7AOQa80+UnxYfPo/Jwe1Re3G83MUvo053zsng0/X1trLSSm4l7OfGJ5?=
 =?us-ascii?Q?6f6R8DukZjY7BRkPCYBBos9YsiZkvNKM7mD7X5Krqp6uJ6No0Vq8pi+fgQOO?=
 =?us-ascii?Q?FmtpLk86ApQig7ZA70L2RYtYpysK+oOI7pcP+cxhniiyp7b/YYEfnynVp9Jh?=
 =?us-ascii?Q?OYH9aIhsKNIB+qoc+msGTp9B4f7CALHiHMvCwDJSU+xNTYCkXT/NiEWg7rx+?=
 =?us-ascii?Q?YYhSj/0uisb9D+P8kXpX3VXOcT527L8uNi5a4t7ANn1fKNmt1x+DwHlrhUWZ?=
 =?us-ascii?Q?ICzaau8OVi9/TlUjIL2xgAE6KQC/mxAwcD2U9s7BKD6BTZzud3giROyw8rF5?=
 =?us-ascii?Q?wL1dMCROTY2oW7KewOubQS4xCEIo3VwZHLAaCifRZZD2oCmJfEOw9ZvYG5/m?=
 =?us-ascii?Q?pUVKdE4fMspKyz9o8tCGDrRgYJtuEnD9uLBJrHXnbrlwyXmFEtX/yI3JV+m+?=
 =?us-ascii?Q?uW422S+L9EAHKIMUvp4i+IX4YHeY0BejfqbY7/ZBW0J3StxFSUWXzMEwaLHr?=
 =?us-ascii?Q?BHUamIoMQLSFxhpxz+nmsxzcwgO40tfUyNXmJ0MXYLtj7JEwrdYPa52XExQk?=
 =?us-ascii?Q?WsZLoNMufkJJ567b9SUWhOAo7yXsVnY4kaNOiQ67po5ZN1svz7CRNXjuTCVH?=
 =?us-ascii?Q?4AMCpZRtWwMayyRcf7lJP9bZMmPCwjvH5O6Y5ZBmu1QHnYT7MhY3gz09D93v?=
 =?us-ascii?Q?uPG3am9Iemt/GjSWNX6dY/2/udsAgMSr3E2sukzPrH0VAF/X9N7AyyQEz4b4?=
 =?us-ascii?Q?JxX3bPV0lSXlAtP/J2nrABJJuhTx3drc7ZiZaRCVVH3iiIZ1pbvG7ucMUdOQ?=
 =?us-ascii?Q?YMiRDpJOAounpm/uL8hJxjN031qO69ZdwWnBFG7F+PcW4yKtA17H+xMExZew?=
 =?us-ascii?Q?7kZmaSibAmbKrgq2ZPizVHz8BOHqiA7oeqXEws68cos4fMZXZpjWEZDROlpL?=
 =?us-ascii?Q?dfDfTfn9wWT//HzaDCYOkScFU7lN0MHlxNooydjyT6oDb8JdVQcm7z3+PT6p?=
 =?us-ascii?Q?YUz2g/S+XthWxda+3v3H3cmSBgLmz8UIsJcZnLODGAL4d6GPestXyVhs9Xqm?=
 =?us-ascii?Q?PtEonFbQWwrISyQMkJm1HoAGD4P19f09/+LagJr/jqZm70uKggA4q+SrLUjJ?=
 =?us-ascii?Q?OjTvrc4DXX/LB3xD/V/tQBEE5kkM0RBa5JEeGMZ2qxCURF9qmgpfUMfUCQF9?=
 =?us-ascii?Q?ojA0ZZykmMFKUlSBqXkEETE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 270b175c-7094-46d7-70e5-08da6569bbee
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2022 07:23:22.4815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Bel+kVQI9dm1zFYElotfaouuRX5C18XuldzlxJsYLg6oLZsg5wZKnRT9VZSFDKhkX1l1+JGUvWUrYZdku27kxmS8Ieq3W6mXCEwqxNAjOo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6522
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
