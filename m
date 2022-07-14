Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741CC5747AC
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Jul 2022 11:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbiGNJEl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Jul 2022 05:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiGNJEk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Jul 2022 05:04:40 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E69B1FCF8
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Jul 2022 02:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657789480; x=1689325480;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=qaS4rRL7QGQFb9gcjhvLf4AFYeVeHFLLLQy4w0WHH/8nNsZkk2aa1YDn
   k9Zsl9IV8xfol6HZVd3MHuGxgzAY8Er1cVFj5SDO1kq6mZSShNlj2Hvun
   wpBO6RqTqpclDsX6xCsv8y87LErrP4vOazOKOCN1LTqDKXD1uMkD0kIPm
   3XTqJPDDaOk6Op7bFr6qKKvajT/td7//WHHbIxDeXeezfnE/+drejYaES
   3HwHEISfQyksTNY5Dh2SHTY36rPIQaruY47vt8G3DiNxxCLJnrVhjOoO3
   AZRQrNPKVgHYxxg/bwyWrufcQGZBZOxVR3MC0Yjcg/jAAMMbBpgDLLtNz
   g==;
X-IronPort-AV: E=Sophos;i="5.92,269,1650902400"; 
   d="scan'208";a="206394093"
Received: from mail-dm3nam02lp2049.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.49])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jul 2022 17:04:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CTWQ7GuFItI+DtDa/Bv8xrRduYbxnyVzAjGlkMloeryr4kkF5K9p2jxsNPAase9E+mjnHZIjayTYcNY+S1pg/jO2rrlzGEfSe9YeGAAfDvTOrGmWS4tDkQUGP4SGZQjmD4q3xgCU6L2rpK5ZfcfA8fCyuFRORaOQbPzkT2eGlX7WlnPOBRqSjCA6sucoo6lFDZsI6V7LS9V0bKjr/3ocZI87hVteP7C7Bpl19bTwGAF2uSaUoPxdWajSDjdiImRgnxfAQs1hZpKrKN8cLu0hdbJhT2nEBSUJd/QLfVr7xU77gp0Lj5iMHA8uG1Vjo7/w/hhgADxDLMnVzb5njOgH4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=me8E2uAP8wEzCqFRoNvaYnGsUD8SjFU1FLJGStAAb7twvwMr7r1xl1nfyKWuUrVPS3uIE9BZbflfcj9qebc7kOz8gA5Qy6EalFr9U4maawwmMQeYD+11Yf0aVOKZNbHyK/8oW51fPhj23c95kefFFW3NBZKE83QNWwriUCNdE4rhYlxvISOkZLpoSsky++4e3i+TQbbKoorupEUB8XuLaoU8ML52CZ0FaA2jJPv4pUOuvOOnTSKZyhf3kj9K+Dm3Ayq35LlKdSdG21jDDnYEQYQ6eR8M1FQ0aR0eNbjJVg3tB7ylTDOhytN7E75LNSsvdUDo8AV3wnwO0Pk/S4wDmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=YA0FLiCFHK7wXqHPQKhfQnz3t1sBZoD3JWwNioEv3fopEGvqcqoVO+aS0Mq8umD18JQrWvgBcec5bnZ4vt+Xs88hqHaX8GlfZJ9LaHJ5JdvdhMt5NjinRZIwk9+c8NwCQCw3rRRgcajD0kNdEIe3S9iP+wM2SZ2l8GTH6agBCV4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB7568.namprd04.prod.outlook.com (2603:10b6:a03:32b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Thu, 14 Jul
 2022 09:04:38 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ccb9:68a4:d8c4:89f5]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ccb9:68a4:d8c4:89f5%7]) with mapi id 15.20.5438.014; Thu, 14 Jul 2022
 09:04:37 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 4/5] btrfs: simplify btrfs_put_block_group_cache
Thread-Topic: [PATCH 4/5] btrfs: simplify btrfs_put_block_group_cache
Thread-Index: AQHYlxl7PKsKpibwl0GFZvBm011DQg==
Date:   Thu, 14 Jul 2022 09:04:37 +0000
Message-ID: <PH0PR04MB7416AF018010057C86076A269B889@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1657758678.git.josef@toxicpanda.com>
 <e826fefe2457137d3aa8bf904de3c1bde250d667.1657758678.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 15151a39-7bc8-4934-a6b1-08da6577e121
x-ms-traffictypediagnostic: SJ0PR04MB7568:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nejAW7G5rb4G9gfMcckiUl2MoJHkWNzYY8l8SXU0NQ0kC43uxVeu5VS/avkD5RQu6zMbRW4XhQ6K3lQ9zNXmqooWwWx/jQ4fylk3j2DYlMGMXRfSDLjVnPlRVkMa4m61WlUUS/CiY9abRd9pHE0K0Gq+LYLMUuJd4kimWf+dpfWEvkfNmAIk6OpkFgICBarXjo82T9P4icK1tl5aDT8aC/uNCybKZ4fpWp9lHljkmPsv8/smqoxTYbpzGD2ONoQLhZjP8BMnNmMkzUfOgUk7bVLSoBK+Pw67b4SfVxLGbVO+/MfCQwClwhEGO4UH6Osgg3tigv4xbwTR+ijOOqk6X1WjqYGYLHBeshE83BCG1CDa7+kjos89hmINJZT2mTP14nIKnfvOZhAOUoutsWRLL73gQ0T+/szgxpgJDugyYEy9LJ51JAbLRv9N0zMkLEMI6NdESBqPKubj6917nXSmYa2RZ2j/STIFK2BYEfdrSM+pKssgjisz0o3pyHNam1UBfsoNgLHq00wG7Fc7TAZxKwugQT2vQQLSkQZvNVYFb0AiWfe/ewXSHjz0dxJs4mrW6EbokGgBO6oClDu2JZUKnol1tYsuOE+3nUN22tG3pH25Bkop6NBCQNn/KBQZ8zUBQGC5q6uOjNm5/8r+J9xSc9rcwSkHTa4qtxZurThGiMq2TsH0Z42SAk5FQ23XN05UZxKOLpJUz185u0pJwF51tWL8eeeW90QGNr08H1Od1CNFuVw85tfHt2+ZMs1CymI12Fzj4b6zctQMixwyqyGSwDFANkEWmFGhTs5cdOdqoXFkJjcvh4HfFK/144U3+7S9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(346002)(39860400002)(376002)(366004)(26005)(9686003)(316002)(4270600006)(110136005)(478600001)(71200400001)(55016003)(558084003)(6506007)(86362001)(7696005)(41300700001)(82960400001)(122000001)(38100700002)(38070700005)(186003)(66446008)(91956017)(5660300002)(64756008)(76116006)(66476007)(52536014)(19618925003)(8936002)(66556008)(2906002)(66946007)(33656002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CwuVqzgdkaJdXCAV5BVMlxUgFteajgHUrZlm03ApxENJ93ORQZo0gCGa11hJ?=
 =?us-ascii?Q?xQpsCRc6QZOH1fhzRsseFAHLnPNVOPZfEM/eqxGJ9FPVOFBGkFdBArDZA9on?=
 =?us-ascii?Q?MSbSRRNxYh7GKXgRceOi4XcCCZGqZ34n8fPxn2bLNAcGL1m6MJDRh8lZDgFY?=
 =?us-ascii?Q?1jcHQmeINesrJHCx677khU33wpXwDkXCKKHk/ikCXyBKY2pp3zF8JukRlqn6?=
 =?us-ascii?Q?CXodeV62ShYkPCEa+gQfH14VlejbFGGgk/KvTvIJGCmhM6NljzP1nGxZcjSN?=
 =?us-ascii?Q?QrZnGaUkEgWClfSixWsoZyD8CKJBDRr7u0WiCIzpE0+wqKSJycqBV2xEXxA0?=
 =?us-ascii?Q?iKY0MHQjFs6L1cx0F8Tx3ibbdGyEj4+fPe7cf7D5vHhIuUBg/6encss/XnLo?=
 =?us-ascii?Q?KVRAA3Wt9KVNG09pO65h83nMtkO2ZUvBYZ1BmeChmlQksxMDnV6IksoU8KWo?=
 =?us-ascii?Q?StUDYRLo5ZAYxJ6t7nyG8U3zK9bn+tvD20Vi41N0tZ1FgqPdsW6Tsq/awM67?=
 =?us-ascii?Q?jJtWKtbO9G5IiIlwVJTpFf+Uw4mvb9gpEfPbK+1cpc4oXy7yeU1jLbCvLCYW?=
 =?us-ascii?Q?N4/Zi4ON+2wtyuNgM+grI8M/bV7tWBqCsQfy8SGcmWYviLwa3mQeEXqUAQwm?=
 =?us-ascii?Q?HsnOXND0DcU901Y2AcUG3QhJEwEdMo5axjnuHIyEdu3tF56U2y7Jl3hr5we8?=
 =?us-ascii?Q?OaFJaig2pRufBZfuiosZ6SrsXccJZxqn+6BxPcpug1iy2vcHyJi0OjaZpze5?=
 =?us-ascii?Q?otaZ2InJYKG0w/q6mKqk4UKKsQNgCOTG/XRtOQj60P8K1XLFVmrTkoGhrYe3?=
 =?us-ascii?Q?EcrRb1r0yGCRjHebpTupQwITtQuWVA5aLQvKaTIKuv9k6JDq5Ix+6PXuWsdL?=
 =?us-ascii?Q?BimXv53reqQlyGVGosxWtLDm9ZcHS9iRoNvlFRk56v/T3o+ySSpfcaeEW0fk?=
 =?us-ascii?Q?WylbZU57Dy8q6AjEFRoDHDXM0m+zpwVVA9AVshjNLFbQn7dQedhYRg3C8UGg?=
 =?us-ascii?Q?fIKY8zfUzp1FpY18g49kLD3xKNESjUhk5GuutpkXiJ3f9GG463svuEmgCox8?=
 =?us-ascii?Q?d2s0jW/DPkrKfPdNgS/cJei91k9Q8ll1WxKqDC3ucSEVKJ9kb8Sct2B+TPFx?=
 =?us-ascii?Q?E9IWSzw2vrziSUREX/KpH7N8RsahPKrDfoypbFzQg68iALl7tDzXJqIYmYqq?=
 =?us-ascii?Q?twS5jx5cYArIAn9rUPo1+id2LNRM/pET6X3eBGDW7uM4E2zFZIz77+AvpIYc?=
 =?us-ascii?Q?eymvyYlgKmjByM8nCYNCoyyirrVjjIsTAB8FBL2JVihOiHvrNEY42dzwwWMg?=
 =?us-ascii?Q?nBsFXiypI9ubon2gJDJD8IdaF/2e0vkAYZumxCk2T4KWqIoT3YX/0zi8FYdx?=
 =?us-ascii?Q?F2zGKPKoV93nqwgfRdY4sSbUOAbOZXxW5OMj/aYLP5nR7MompBMxIgqYD1MX?=
 =?us-ascii?Q?C5lGYyUskFqi87399U9frKDiq6VGvJCZAsybLmgifmclWdWQvL+Sg1r1pdI7?=
 =?us-ascii?Q?xdKF9c0fmLY7qDmvpztKEg4xAzI26rJQMPNzTZS7k1FTkWmYpilHNWrgpvgp?=
 =?us-ascii?Q?zXachwUbwIeK40pEQ5KWPxJPvDsP8FfRY3RzSBKvHmXP0dBwbvY4eb2PM5Sy?=
 =?us-ascii?Q?CyFazNJs2G/3q3YRIXuVM+A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15151a39-7bc8-4934-a6b1-08da6577e121
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2022 09:04:37.8782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1gXxrifnKzknhWfxY/IKugdWcbOzNao3hPxJn/NIbB+Xi1EMkq1FCj3tv2vHD3/2kI8N2Ka9lCn+wXS/hL+JR6O+5Q40uX2koYVloJvmD2w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7568
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,TVD_SPACE_RATIO,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
