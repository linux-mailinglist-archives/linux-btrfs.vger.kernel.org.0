Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC60E572E1F
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Jul 2022 08:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiGMG1c (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Jul 2022 02:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiGMG1b (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Jul 2022 02:27:31 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D41CC037
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jul 2022 23:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657693648; x=1689229648;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=e36Zi3OczPGiTVUnBhRrPeVqcv2J1wl0lhi5Lmz2gN8VX2iU7JM11exY
   HwxZ+sFTZ97I4h/Bal1Ee+swxdb5o/psjQSNw4ttW4WqHetLWccuJMgg8
   cvTdtj1nXkbaMPJXdXUNcXCTmfjazdI2VDXnxLIjk0jXvjNjvb73U/5sF
   5drZ/hLzRoW4YVYgumZ40vsclLtyXJBIg92HYohtU0QQiJDM4To+XCodf
   wtSlNAHxLpN8byPZ0/RWFcSdkwofL8c1q8S2tpUh450he0JZ2zKIcM3hh
   OwlWR0jijEHtbIUUTJkm08hk1NErgQ5pRBqQfCoJp1OdNSIUnjsA1gAXT
   w==;
X-IronPort-AV: E=Sophos;i="5.92,267,1650902400"; 
   d="scan'208";a="205575632"
Received: from mail-bn8nam12lp2169.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.169])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jul 2022 14:27:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J7s1QsIqzBIZgx6o7+CxnghLmhgDys7MUp0NSm7B3D1JONy2mFzz3ujiQqHgrLrswHcw0vMav3yv4jlX7QI3EWJAtZ+G1IspjfliM6gM6ijFfwnO+RWAnRsXJ2dcOfSsxb4o8mCaLkn//iKaqPMgz3Kd+ISI7/ElWPDeZDRcbiHuh2XWhuarv+Dm0ZhxmwpijZw9KiL+4bJyAGUyroIQWmcttRRfwqSDKdg2YDbL0f2k4SvacojVfMRZE/tYtFNHiCMkzwvIqDbH5dtqYpbOzQ1K8fPhJmGr01CEbvrtXa3rCIANTWfJZ3PAJD6+r2YuvtLIRjYUTPGSgaL9rOVMvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=UgddSxxKwFnunpd7A9ka/tAe72UhE5pjGHnOB7QxGSXO1N+uzYF2EjQjJNeLpwmOt3UiNtSb5CYh35lJECR1/3H4d+kZExXEDjB6wh1hVM4yzzNyQdfwGAaqCN0ivPEoq31DNUWMBWyO6uYHJSDItG2eRTlBXJJ7v/0L9xkipacpwygnpHVpaHvNXxElRH14Paeq+0DQEk0lOT6ignadWOeQh8LRk1n8nVyYwA/fo/YnkDQzlBrIXjrGE7DmWaQTzgwhkiun2cKkSYfnL4V8ty9sS8IRM7mCog9aRjev0wyzpNC0hwh19YyqPRCVtKdMne5o1X6TTX73elT+ge+AJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=YcYK9z59XjHv/UgVHlNJHYrTQhV7j7hsdn6zUrd7tmkeRxKmhFIXjECdD78KW7arSmfoJ7dz/77d8kGE3LtAkU+ePsnBhhydX7QlL5IiiZGDb0wC3QKCavqr0+ot1YxckYivxlxZjxY5Ruw0n7f8QqG/BxWGP4uwJ5q92XF1sno=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB4203.namprd04.prod.outlook.com (2603:10b6:5:9c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Wed, 13 Jul
 2022 06:27:25 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91%9]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 06:27:25 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 04/11] btrfs: don't take a bio_counter reference for
 cloned bios
Thread-Topic: [PATCH 04/11] btrfs: don't take a bio_counter reference for
 cloned bios
Thread-Index: AQHYln/Jo33DexcjVUufKfcBWCqhAw==
Date:   Wed, 13 Jul 2022 06:27:25 +0000
Message-ID: <PH0PR04MB7416F98B33A6E2F4E05AA2C39B899@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220713061359.1980118-1-hch@lst.de>
 <20220713061359.1980118-5-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d1a53ef-3fd3-44b7-de0b-08da6498c067
x-ms-traffictypediagnostic: DM6PR04MB4203:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qq8Xeq6lLUsqWbLytyzPPor/MYjEQ3LRYyEUSGuYGXcZSOFlNBgqjA2DjmwU6yX0kZF2wy746zEzi7tv1kTVFZAJ8ktQztPK6RbaEN7qbJBIwCXygQHaZBbSAj8smPRb/NLfuc2zc4E9mI8PP5a5rVKovZnIYux1whiGovgtcHKvC3d0avz99raFymZhyqq4RBpFHwpU8ewxL8nWD2WbJerW3AjnJmQ36oEBeSMDcQ57KM6pk52YWjakELKwXJRL3rvCw/igY/ZSmcOh9QgCag0ADKT92zIKJI5tGX2QNsvnYaf4AsG+IS1gVatICom4ZonY4BXbKdcLNh+UdwdOkJTV33eqQEeorbUZ+fA2ICpHn8D1vtqc7XZnXETsV4hcgrkfAwts+nyd9U+WMbY5Dq36zk/U+g96ShLihJ2f2+deLN3tBb+cAkGvWHvb6eQMQR0bvcoXi9wvTYlwe1ClcKEyJHAEJ2KPCuk6SyQbkK6rxKBOR96/5iBbrL5dhruxk920k/LaXI3sQTjjDFPyR5kGcdj7VizNot8/CDV3lPs5bR1iLqaIdLTwOzbXjgakryDNFSMUZC4rX/tS3r1PJRrw9lQqx6fYoPNmWSFmFDirOZ1Lg4cC/PojVc4a3y1ylZZ5zihmQv5hBvJfKpmGAc9cjhjfNdDG9M+seFJXHgtWAEGD9ImkXwc/0Jpedi8zVjnKtyD6AgoHgbFuRM1yn0+kojystse2ZcM9jYAMjP6NuatuY3ehcXt2ccxiYI+D2d1juetQYhgL8tpI/txpUigCJ+p7nB5Bgxx+4Tq07uUccZJH84ugYvc9mY5Zg2wn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(136003)(376002)(39860400002)(346002)(91956017)(8676002)(52536014)(5660300002)(8936002)(4326008)(71200400001)(66446008)(478600001)(6506007)(186003)(66556008)(55016003)(26005)(66476007)(76116006)(64756008)(9686003)(41300700001)(66946007)(7696005)(4270600006)(86362001)(82960400001)(38070700005)(122000001)(110136005)(2906002)(19618925003)(54906003)(316002)(38100700002)(33656002)(558084003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aCakwUEG/E6aucgefKtbNU3CQBCniFjbT5trTt7FToCEC6AN3Gr0NvypSYFz?=
 =?us-ascii?Q?tgZU1DIOsxpPHBw8snpNpOmg+8kKdft91TDMKvDKYCqq4NEdcec4y/2MoPFd?=
 =?us-ascii?Q?9y3ec5BEqfyk4mnT2rV+gUgTef9BqHYL98HSOvm7bBrkng5pPLIQc9PSsvG9?=
 =?us-ascii?Q?8WblN2BfosOJ/g/UicP1ikC1bVbXhX7UaQ31iGteVyNQXrko+1f+Aq1ATYqw?=
 =?us-ascii?Q?IJN1HVa4niQjDr00JcALuST4HvrgeWlElCwKXwmM/sq2IC6It4LuPnb6VZe3?=
 =?us-ascii?Q?7UJd91LDJpKtUewm8kwkRNJiT9ILgcFHR3GqtAUTJLjNve6dzSgh6EI6cD+c?=
 =?us-ascii?Q?C9Dgs1vhn//TSsLUE5VlcpR6/UaCYiJ1pBxKYpti1Yqv7Jm98rVNtN5/E3yx?=
 =?us-ascii?Q?wLOjei/UPZ4DMwjJC8aKth+3T9xNEQ8JcHFHyekje/KYewhfJThZ8Q9hqYMm?=
 =?us-ascii?Q?hTY5o0UpOiLhCm3a52qiA3FcBkItmo2+OYpcd+dqsqfRs8PvQzzKbAs0qha1?=
 =?us-ascii?Q?zU2Q0y9D/1MAUakXF3aXCwd396CchbgKxMyhJZrdkuLN0iMpUBBK0Orjon1P?=
 =?us-ascii?Q?sN56pXcFm7Qq2sOz+Fr/wSokLUIWQJpLvgQw06n5fsKVfrObJaYU+N+9B26f?=
 =?us-ascii?Q?g0DR2QnrK16x44Csdjpzkr+w2NmV545Za4y8t8kowxnaRo4GA4HXFwHltojQ?=
 =?us-ascii?Q?URRw8Fg0Z9JhlPQ7agMBZ1jBWsPNOJhY/RCKVYaCJS70lWrIkeMvBCpZTywl?=
 =?us-ascii?Q?A34BWFeLXZ4UrAVojQiYIDQQY+61PWm71SGWtOfF/2BqekwXLzRBDgCO4o9P?=
 =?us-ascii?Q?ucFVwYW8j59jywaPN/V8ZNIEy+3qemilyjzygwMrRsoNh8WfBLVBXqMDaY4E?=
 =?us-ascii?Q?lly0QaaO4PyzWpQl5YVnpenzxfGtQrvB4W4hOPysxS3t1SYCxQKonKVkF+pV?=
 =?us-ascii?Q?mm+jKE/O4FSzLT80Zj2lM1iQeIHB3qOBMHByQbLP7V4wg7wyI/IkWzS7UFKC?=
 =?us-ascii?Q?bfbQ3j92IyWJOKeG9qOfkJIvZbBQL6l5a1ZpseJNz4fhIpbafZD/DmqTH04S?=
 =?us-ascii?Q?acMFXryUXpcN3E+JXrTKuRZ78TySjJck1v0nFI+yFdbmBS59Aj+v6it2AkvT?=
 =?us-ascii?Q?TD9HJm4wR3eZaWMYbSIrUhEFjtS/kSmou03ClcHPh09bczLYsoIVz8llhcN/?=
 =?us-ascii?Q?Et7vNIeYlQ0VORbpGhCTJtYH0J0UTDKQTbkBwRPwNLkuA7cocbauJha3lRPm?=
 =?us-ascii?Q?/Lp/J/IhvkqfvoSFFC4dybO7HE/ZARoBFPVtKZ425xfpk52fVyFF6U5B9I/N?=
 =?us-ascii?Q?xlbapr3HKtlnvbTRccbh50i2RXKVfMRsCt2UdIFbtvXs6PmeG+lhOqkjBaA5?=
 =?us-ascii?Q?mZzDdVZziK5JgNqsEWma6gyGZMqgvfyCrvP2Cx6DyrXT2vek4yh6gEdH7xuq?=
 =?us-ascii?Q?WJGljEqtre8qo/Eu8DhI1fKXug03zxbIUixGfW2D3t+8BprZevFrjQaM+mjh?=
 =?us-ascii?Q?z/ocIKzx5IOwU4aKMlLLfWYn6rnxZDujWwJUI12HYyk7+CZu/+Qitl/CzYRY?=
 =?us-ascii?Q?5vycYd7radaaG4nus6EHVbxBc7s0xsUACyy4QGFwf7q/r+PAXiv+x/n0DUJ+?=
 =?us-ascii?Q?mqx1jactVecdjOo64iXrsqE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d1a53ef-3fd3-44b7-de0b-08da6498c067
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 06:27:25.1716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UGSc77syH8YQiI8SRLoklJCH1pqIhJmrsomzSlJCfH0HQRPdawk5jZaJkQhqG9yYDwHxF1gq0EQR/oBb1/ikyF/iiSVg6C26/tRnyjImi2U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4203
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
