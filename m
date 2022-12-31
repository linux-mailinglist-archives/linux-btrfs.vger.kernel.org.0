Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3D165A620
	for <lists+linux-btrfs@lfdr.de>; Sat, 31 Dec 2022 19:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbiLaSsC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 31 Dec 2022 13:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiLaSsB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 31 Dec 2022 13:48:01 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03olkn2082.outbound.protection.outlook.com [40.92.59.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775442642
        for <linux-btrfs@vger.kernel.org>; Sat, 31 Dec 2022 10:47:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TwVTCqRnwnI/cVSClmQ1jqh2FA5V1NdRtXkqaJ6ZPzQ4hZNnxugU0WhySv7SDIG32CS0jw+EOo0KBqRT4oM/AH7vNfIbO6NV7etGK7B/0LVoFJuTwLREVO+9c2z8Av+zoG1vNoUZ8BaMx4LaRu82tAk/UDH9cFvYAIA24q9B+Sa1GsXJP/4m/deb48LY3VziE66Dy5cWfBLRWiYRuujfVGptQnXbfGq/RT3PZylz1iXx9w7nOQ4FUSyKxqh6ED4UBjUW+08swxTB1CizXnPS+rwqbkM6Vy3wS/eYBr5pD28FbtkURuWHVTiTrLDKUYtXFnOn6K+zJNqhoQGiVidH6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bWHfFoWJDVp+UhAoDC7LT9jtU74uhTewA7zlaUVxos8=;
 b=EVPgHE0KmDDCEp4Tp1ktOFEmLDtkE2gDmFzT87hC8hutQKGY0mTCciJZgqXteMqa5gcmtigEuWPPhqnYvJYI8NCzWM98N4g1PLECyTQBlj8/DsJfXSmpYPaPEkHLg9Ug8U2NAv6oFxFGLc8o6xmtcSvtU3HMZ85TuL6N3BdHGzaumd+jCGjxUdET9dxEoZqn1abjPnRx8Pkxk9wZMRB8VzwRXj03lAakC2NC6u+guaOJSONb7yIQ8/nc/ybPsPiMyZ4R6uURNKflGeueOjyQ+DefVGJeP8o4ENPJokg+PCqnfZcxU9Cr63P4hDJDgHaXjuNSopKCrVQXD5M5TdVEhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bWHfFoWJDVp+UhAoDC7LT9jtU74uhTewA7zlaUVxos8=;
 b=A1HHfAV858YuAli4QiVZkxfHPhQnWBaehwCp4QNQioEopWIo4UBYs4xqCHTs2oWY9+WnF79BhwY2qtWzP+3MhaOpGphXPD7E3eEe/gdNcfEVh/KH20RQw7FM1dc+0a/fIvMZgjUCalqYv7llM4c+go3shWWHFJiGXDUqYNOZa2HwF5SiUwqWZr9Z7KdEEyXDxo/7rf4QdYcgckXttcS5BE5GsAja0HZyOP8SMerQFu2V1LwQo3cc16Plb8Nb41ti3nbfHIeQlRGt2/E4AxRuAzXQi2+Jw9EX8bmekg++vCtoNMPGOftIHlPo6jpbNc78b9QiqRea4D+jFCdmvSBexw==
Received: from PAXP193MB2089.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:226::18)
 by GV1P193MB2277.EURP193.PROD.OUTLOOK.COM (2603:10a6:150:28::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Sat, 31 Dec
 2022 18:47:57 +0000
Received: from PAXP193MB2089.EURP193.PROD.OUTLOOK.COM
 ([fe80::9da1:872b:caa3:1379]) by PAXP193MB2089.EURP193.PROD.OUTLOOK.COM
 ([fe80::9da1:872b:caa3:1379%5]) with mapi id 15.20.5944.018; Sat, 31 Dec 2022
 18:47:57 +0000
From:   Siddhartha Menon <siddharthamenon@outlook.com>
To:     linux-btrfs@vger.kernel.org
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        Siddhartha Menon <siddharthamenon@outlook.com>
Subject: [PATCH 0/2] Check the return value of unpin_exten_cache. Cleanup style.
Date:   Sat, 31 Dec 2022 18:47:47 +0000
Message-ID: <PAXP193MB2089D736D647D6D2CEF4D6E1A7F19@PAXP193MB2089.EURP193.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [qEn1IIMvUo9Gg3BL9lB/+oWV6ppbaE7+]
X-ClientProxiedBy: LNXP265CA0083.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::23) To PAXP193MB2089.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:102:226::18)
X-Microsoft-Original-Message-ID: <20221231184749.28896-1-siddharthamenon@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXP193MB2089:EE_|GV1P193MB2277:EE_
X-MS-Office365-Filtering-Correlation-Id: d03b02e8-e1ad-4575-f290-08daeb5f8877
X-MS-Exchange-SLBlob-MailProps: znQPCv1HvwVdpFgLlmRDKutfW2ESK+VMUhtdnTWgTjNt4/4TS0zwAxj7RuNO/6vcwEOxw40EPrY/Dghs1lXFkMTfNLiS7KzgnpIg5JSPU+JLhT9EJWokVtrduPJ84ejFkOXZXjS7Q8dDhP4QpwfOMFu96thzA6ZEwhKfrumTvYihToy1Jb9NmW52iEe7YrESVkzaslKQLakNBoBjphBYosgmMQUXKdDjkJj7WJr1WzGXzj3PTY75xdGtMsVFrNNzPMr0jvDWB9XwKMxQX8yBdfLhre+f/jIORQHntzyuGtYDavFVU8r3S+7asBf1+r+v3tQMtyxEbvgTp3hvvfOIAAt7WJvjNwQ2zajpZgmILRtGoKJLtkBK0VjQaiatr1IfxizECUJkYG7uvjykPSUE/YouHVr0gkNNpm60frajDHYQ7rlhfPZ0F5htwoWoIyuEzHTd3KPYaXP8cTB9nk3ahtEtdCIWJhaIfViyJfUBij8GBtDoNfm4tJa21JNojDiYa4WyQ78CklYYn8SIrwXdskrRLxVbOgqcmdEF8gP89/LHO1kkZy0/9RUvJPksE0AZ880mljodgpuH1qg5LPhXiQeDtEwjRLQ2tkebRKKQVc9l8uHdJUmqP7u/2mbfyN7mvv9v+hZlopaEcEhDXCZdoxH3P//9GFTAbU01CQxLZc/RqTIQTGpLONciK5phny7acfNpAXYt6DfuhX9J8WjUAaogOfLhiZHQu2WcvllCeIjLetySj92ZC8sFx1xgd9y/+jwwdhFSUls=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fP13r/D82J6T/NaMDaD5mxSKcNzGKUNnAH2l9VHh/QWeTXU8wt8w/UkZlPh3VKyOFFHdA09ftiXiKDMqWy4OqMtmblZZvs+ANLYRCFolWIKIjnGMmdFlR3000cRjCX5RhYiTBzjGWJ6YDp6IjpphSFnUo6UOdtyR4UAC+CnK+sNtW2qblubeSdQAOMMHGxOzQQlFBe7Bv8KocwS8Yk1rCJ8Odtwo12unlKt7VATwqOrd8c9sNPeESvhkTKQ6vYF08Z6YNWpso8QahWjFg9PZKnRgQpV9SgWDKZogdfxa/o3jfuN/TRqQBA79AEe/f1NhU9Kvk8AM3PX5uBSVPKlSeo7YSoLGzvBRVtf/F7+KLvwqSIGEmKkQiqnsphtlY+gEShIZNFix4JjeUZR0/uMqb8H3oZ54b6dPYEEvTKKKWPut9ZYWvlZgFExtDZu2XnKa0LcZj3RC9+yz4SPLqAVR/coRmDCC16dm4dMcbrONEJWHAnAdnF2t68GsWoBeVMKm9E9EnJzkXAujRYpQ1W6b4LwOZcxg5qAeePT+4jq0MliSzBmQHJP67j4N9HegffZ9QqBCa/F7yAeWS0wQ5wzUm11ALgooCvWJkw2McfXm5pZqvPpBeDSSMJ2+oA0dpu6ZhU/gV8UcWP/02zQvbNRJCQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wDfbz9j52phF5ytOPbjb8EJDltU+uxUYJEMcRtN62A6tLXpeMqTHsZUgYfCx?=
 =?us-ascii?Q?axonIP87R/jhNFXX1zsXHPZYnKuKHHSKLZ6yHnUYvNmkZePvvoM7RoWCEXvm?=
 =?us-ascii?Q?oV8qoVofpopCSjRzfuXu7z16QQClq3CcvoFD6Lt+wjOsOx6YOYnue69YAzwn?=
 =?us-ascii?Q?xsOgyNcRk2VLUZEcTyAs6ZtSQ4LvSFcC6m/PcFH6JpyFWzrQcDXc1igGTc7b?=
 =?us-ascii?Q?/9APtJG4Rw2WuFfDcOuLOUSp1GHcLwSOKmpdqOCCqeRSb6Va3Snt6O5UNhPn?=
 =?us-ascii?Q?HS6XevcglnUp99yhHcO1MyQd6TdEwDvhus0CCCW7WxGWcZMpH0wzBuSOm16T?=
 =?us-ascii?Q?1Ztc9jFuNq6FKg3Q6XPXbY74rCtqb3CRGFYd5urLvJgQFRMiGfnCKYXzYX7q?=
 =?us-ascii?Q?ywCCHFDMVCRkNSSmr8Y4ioeM4pLc6YJD44dOFScH4CX1VpEe+76Kq8QjrAHj?=
 =?us-ascii?Q?XxtlPOsaBUPQI6IlE7pkEmnzdOK2iJjcajXslakZ3dXFVGzTs8Sf7gadEp/G?=
 =?us-ascii?Q?g3nCheuOCOVSQ2vIoLb7f40To8LTbgyUUAPqLGqC/lmizm6syL52k+UWZjN3?=
 =?us-ascii?Q?Wu89DSrCPbrckw1ErXKQNipEr8s918m3lki/HmxMOp7xNHZJ7t66cQUBnCkI?=
 =?us-ascii?Q?ZXynnhfI0KdED2ZQLT9FPsJJoIe+fDfeKglUxWKgj6uRivgy/gOt3B1oQmMQ?=
 =?us-ascii?Q?rfv0CO/GJuH2GVywdXBPFu/qHugenuIlumvk/FSsrXROy+3VAXpqyWj4y+/X?=
 =?us-ascii?Q?iYAeABBoXjjkUv+vO5/x40ywIDLwSMV1010PGGbTa3JV9aLn+dYVljmzF+Nd?=
 =?us-ascii?Q?ZoiXxb0+WtRyGE4lli9r0w/1Kk0erSeyyEOyUbHi3W9UZzQJKz4/eCAT0acB?=
 =?us-ascii?Q?h/aTCoCo6KmdAftcpxKI/8ldIYA5dNKIB0GY6VHI368ARQ7ngCW/W7jTK0iD?=
 =?us-ascii?Q?7lD4Bq5oEV2ozf3C+SGqBMKSybwNNiZv75wdwi0dxm6wEj9n7GJuNclQaHsj?=
 =?us-ascii?Q?GCSyyii4wNE3fKoDFsWKLSmi1miExUYAsyftv5VzidIhilhPHNyIRMWUS6+I?=
 =?us-ascii?Q?21d3feUsY/PGagHxdD7i9/AFE58AEgLJFcK5RJ4l/pIGSOBE//k6iBijJwtU?=
 =?us-ascii?Q?goM6WRs49avT56znBxu5QJ3dU/JHpXcEwKD9BCsAKdWBwaomXjIAoO0fwPXn?=
 =?us-ascii?Q?i/TNYizrOO+nr3TLLeXgwOmmA1XLjOoBJeV8mstoRdrJPyH/mVnYRQ4bGkEH?=
 =?us-ascii?Q?RQzkYTPtocMZXoZprZLBY9QSzy79bIkKGuHbN0963R2CqUmZdtnrb/U2TA5w?=
 =?us-ascii?Q?SBk=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d03b02e8-e1ad-4575-f290-08daeb5f8877
X-MS-Exchange-CrossTenant-AuthSource: PAXP193MB2089.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2022 18:47:57.2203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P193MB2277
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

These patches hopefully fix a bug and cleanup the style.

It seems that in inode.c:3335 the function `unpin_exten_cache` is called but it's
return value is not saved. Therefore the following if statement is checking an
old value of `ret`.

Siddhartha Menon (2):
  Check return value of unpin_exten_cache
  Fix several style errors in fs/btrfs/inode.c

 fs/btrfs/inode.c | 51 +++++++++++++++++++++++++-----------------------
 1 file changed, 27 insertions(+), 24 deletions(-)

-- 
2.39.0

