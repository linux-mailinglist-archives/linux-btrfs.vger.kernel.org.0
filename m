Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689DE7B5F82
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Oct 2023 05:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjJCDqk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Oct 2023 23:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjJCDqk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Oct 2023 23:46:40 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAF3B7
        for <linux-btrfs@vger.kernel.org>; Mon,  2 Oct 2023 20:46:37 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3930irOF021736;
        Tue, 3 Oct 2023 03:46:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=ABI5l8AifyZmna6rruL6O3t9w5OLE87hnyAKtWTsY/c=;
 b=olh/6bKVqJa4AyRBFtt3tVTTbdKhslMBg4DrjqW75HzQZwJOKDZPxgsQ5teTuMirptS7
 pm0cYLo8AUxJ6opXO7tcPc1ghNpA/d12g2IXnTclbGcb1uiwv2vECZMmLjPkFMzBvulf
 xxJA1gsEFO4O/Mwbv6ywb1SzTAktVoCnOOqA2Zl+P+9tP9OrzcHbHFlUcMMh0elaZ46D
 IWzjnM802s/GezSn3xRcvdpZfYQwNFJkWKgVLMzIy4AUISYixg5MSAJIIAxDj+44WOlz
 0I10M7/Glx/fyO5KnTVluOzOxVNf3/snoq/bQy6FfPMatLMXG2U+85oZf3SZEUTirdsO bg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3teakcbu28-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 03:46:23 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3932vrit033772;
        Tue, 3 Oct 2023 03:46:22 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea45ke3s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 03:46:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IOrtr8nkVDScaHeaWWfEPgMD6MZf/w6xqgB8ZNFDIVk6z4QLosvDlOQXhSTDz0MbOEDhiOadftmYGLZI47VI5GaCYGAat+S99g5d/Zf3+ThGXmCM6FKYk2Vh2qyCzurxWG3PUNkFZPIqdnn+6g5mxvScZrlVtkZdd7hjEc1melxj07MoaKPZmcY55+J0Uq5Px9MrggY0JRXD+LNhAltR5wwXE5miGNGpYwOZrupmvTB/sKTmb1S3ymMryI3dyBDFkGYTD+lVmbBJZVTt5u3zEIFJNYG+Xo5hSGN2PnAtSl9IfkZuoN4pYZpW1yK6z/Nv1nGVdKJLeTh3YW6l4fv8ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ABI5l8AifyZmna6rruL6O3t9w5OLE87hnyAKtWTsY/c=;
 b=kW0PcUHLco0P2o25/B3464WXQ0rcGqddYrk3JzezSDwCNYuCw5gij9uuNJ8+5ob64j83SzCH704gvavEYg4pimm2KzWZc4xw+D9aA75fl+Epah+tipIr+aQQJ33X5t0IJlSTIY6VFQJeDxZUVvvr1o+dfb/m5lfreh8lNIA5buorhb8CXiJBMQOpk5Nwh6XZuj+S2tGbI6KXnu9YgZdM2MeLHQKrgGnkqg78GmfONx2jZAxZy/MVsU/BcLbLYzSINpNzhCYN5g+v1M18Mh9XlwKiGXkA9jjq9PrhCOzIIpPSfu7Fd742XAlgaZjYwzWDJKjCdqbwKgMLphTqOZ3Gnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ABI5l8AifyZmna6rruL6O3t9w5OLE87hnyAKtWTsY/c=;
 b=W6rh9n76B4LhL+UdV09mLyTm2Q98P4HaIy406W0HjjfhsHwR1AoiCpbDo6huP8jeqp/Gq49GGoIESjZ2CWhDSYp6FW/4ekBT0tvK2YFrtBCsgcGeW9VnPbvuUTbfOzX1XvJszmpplbJLw4lRE33Gb33qMHZY11/aAUAgSngszd8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB4511.namprd10.prod.outlook.com (2603:10b6:a03:2de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Tue, 3 Oct
 2023 03:46:20 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6813.017; Tue, 3 Oct 2023
 03:46:20 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, gpiccoli@igalia.com
Subject: [PATCH 0/2 v2] btrfs-progs: mkfs: testing cloned-device
Date:   Tue,  3 Oct 2023 11:46:12 +0800
Message-Id: <cover.1696304038.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0033.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::21) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB4511:EE_
X-MS-Office365-Filtering-Correlation-Id: bdf787e7-d5ff-49c9-e699-08dbc3c34e70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KXlAIW22DZuWe9wdS+WvljVOAajG+f7CIBO70RSNzJqB74aZHptpILamaHm2tJrJ2QnL2pKKM5AFKZEfHkAKAjHUS5y1Pxt7bSCM2ZjwpqbsSwPfHIwKOgzY3XpeInpTFRqYwWov+/tijh4Y7WUIm6g6VTakznbTGsSB4/K5W1amkVflySACpr29nmxeb2fMp9fa7bN639QPw4fqzDdEwVtDCmJPRc88MaXGuQuPx2j/4cJUZ0BrbBc4CDj0CIxYJ1I2SPRyB0TIDGgxypeaGQr68AedgwUsjVeHmQUUDmnmh7paZnemCDLfwBgyKXlgJbFxMrfPUax5wnQG6TWNzNqv4zcaxT40UmoyQwS4Ro6daJrNovKSOngtn4XXl3pmDcx1O54YwZWqp3gx1PMq6K6pPPEJDNCE9KrismJ53F890az1Q+1LLVcRhd85xVnfDNRMqSdewSQKDHbmpEGNyRHcxTuWeiLzcmkg9iorDk+ueL5P9buYmbV8JFrvcV208ijaQvMmttt6whppDBQNDmLsO4SCAdfX47MgBOjTLi+4Uc60clk474G0upqHsgU9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(39860400002)(366004)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(8936002)(41300700001)(6916009)(2616005)(86362001)(38100700002)(6512007)(66556008)(6666004)(26005)(83380400001)(6486002)(6506007)(478600001)(66476007)(5660300002)(8676002)(36756003)(316002)(2906002)(4326008)(4744005)(44832011)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Jo6cYjT5hAtaxvbTNjsexTiIYkFrFP6fg5fX9qhSaKV5MT33d/01YqQwnJEU?=
 =?us-ascii?Q?lI+W48ls7jz0l+50LyauWj1q4nk5cwl0/pOOnRh+5T6Psn/Px6WFTxBpOtjF?=
 =?us-ascii?Q?f63takQvKPwAtOShOi/zmBkJ2yEFeyKXHvpSrLiDwq3qRqfhKHMUOqaCCMy/?=
 =?us-ascii?Q?j7p/1n4Y65ds+CusYhVg8TlJERv9aXeUSkHIm2bgvJEumoF7soKJHChr1zSg?=
 =?us-ascii?Q?3dvf5ywqsOmjxj0DxcTGl/AsbqW43f4aNnQYeD0kV2syDX2UgcZhp/94rmnZ?=
 =?us-ascii?Q?3/yeqy5aCxTi1El2qS04lI9IgCiNv0iHEN/0YnmswRTbn7SyJ0zKuobHDeNF?=
 =?us-ascii?Q?R9bqDKctDyQV+hIUnyK4n518l/HwuRvTHdauIL9KNsZ+UXO6AO0jCGWkKxkj?=
 =?us-ascii?Q?7K163lY2pYkKleZ4PjF0yeYgOq/pEtig+zoEZKSRjVVoNYYKUCa21W7357n2?=
 =?us-ascii?Q?V5NFOpP0IoMrmnH53nOQD/sQvPI8770lc4YXK26iWyA5Cr7XmMtC64GDhgW7?=
 =?us-ascii?Q?J4N46jk5ni436KqWKLLFIEv3n4Uz1zJMZA1YTrV25KV1LQ0l48VzKtHY/HEw?=
 =?us-ascii?Q?wwwP9ZjoGM2RcvoO219VIYixNQDuEmiBR7JmLzZefkY7c6rRKX1kMVpBXLQB?=
 =?us-ascii?Q?gSxRukusgWiqzK+wfS/D5pdR9psTQS3b4a7VY6N9oiFqmXmhFbj+zfYDwGEv?=
 =?us-ascii?Q?aRizJh6e1lFAM3IjKgdyKkQ9RPO7E0eWcGCdqo4Zh9F1pDzE/9Ipwl31sfzr?=
 =?us-ascii?Q?w+hz7UaiBB25k3/zB3rPJGpTXyva8I9OvvUMhw8qVmG/6iVYfv/HfpB716p+?=
 =?us-ascii?Q?9GG3PjqTWQoF/H8447gGqUJNHBZ+TsWuzC9Zu+NMnacMhNWSA4NWXtA4GLWH?=
 =?us-ascii?Q?VEicFSC2rSeDPgGGak88KS0HR31scdf53E0bvk1QTDMtP3W22hOQUYGrXSfN?=
 =?us-ascii?Q?vvv6kzwvlYrPsmprKwpAzYu0Ufg8QjoFCF8xQ1fEtFxHvveIpOVYSORbw+iu?=
 =?us-ascii?Q?xtHlEPm1Ws2eO4qnR+MNZk+t2HZywvhNX+xWGXIqHm58YFpKLE4OlmpOmYJb?=
 =?us-ascii?Q?OghQJpNPVhcOZQYp7HpObOYSyX+PbZRpgTPHjjLI14LHrfPVR3YQJhjdA4D5?=
 =?us-ascii?Q?nAaLIfNzzgEWuJvN+BEI8D23IBiAJ52n3TIaKbl8pohNTCyKtd7/kIeuw2M3?=
 =?us-ascii?Q?YTadoLZlgce7N3GxakvDAkaxQtQf+Ny5MWSlQ3sP/ZA7cSlTpthxTA08wTLX?=
 =?us-ascii?Q?qf/nfr3j8FpYcrE5bUKwy704D83hX5rWGJe5vbkIy/728s9WXbzNfwyhKUb2?=
 =?us-ascii?Q?3SpfjoCXSElCOpRf0R83rwD9Gti8SfkMf7F3f9FXu3cGEVIUk0dz20k34Fg5?=
 =?us-ascii?Q?peRzASw4LX9weYKc217pU1Y0jW0dXL2Fnqa37fctRjPmCjTchm5q7lx0CYP/?=
 =?us-ascii?Q?iUnV07OjsjsXpssGn8pPBaMtfudWucS30Eejx0qtOoaLV7AcYtfJ6EpWq6P2?=
 =?us-ascii?Q?sNrSMGM9g2ZwpFzSxdQCWsymmcSTbbRXcMGphoJJd1iLWjN/BIDQ5AxAQTD4?=
 =?us-ascii?Q?naHLTHVt0pNUABgKvfq1/rPXrDMg97IZfuAyxeQOy1RHzSmS/0S5qcEYWVg3?=
 =?us-ascii?Q?Tg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tptjLHEy94tAeMLVZrD1tb3/+jHaN56Cg+G1yRjyD9h9GzzvOgsjvExzrk3AJgPZUIo8Gj6FW7qobT37uIsKEHNX0yLayUTfEkOxvbc7XbQnIlBtlDuB8+jeHEe3QtJnKpFlBScf/Cv0AGYuMYSxgtY/D1l5ISH2vi/5zi5sPRhCO3JYdHzL6y5n/FLI4lX7sqDODJyzCUPp3ApS84cYaPYsWps0Ect+CZoKIwmC8uQu0DkgPA5aYYVEQh3nOcNPpsikeUtdpv8ObJ+FYBsgE0RY7wfMnladc9zD+oJqWFcw8C7u6kZHOd1/eoPWOOPaJDwotWxPrKMBHXa9pP2WD2Tm9M/vxFHOw2BbmXlYdZukBArNLXeCSa2VvHnazQdlYceTzbzQZXB/5+GheqMtkICLtEkjzR8ugWEYV3mM07a9H1QMFoFJaLPWY+4TkfRqZckvjhvyuIRhjADDj6zX0WH1Tr7RX6Tuv4al4W0g1nrOVM8Q/T+hnKUIAJ/lBOvn/3/8r42eh1UH5PPt5UYuRaZQAFOqtok4C8r3bnt0znNSMCOponYaBK9Kgg14uN3A2nn8ITi4XVXMK6A7TARqFQJhBCbk/pPoBd79O/H2SdkFMzX6IR4SuHIFgX202bKQCl1Ym0+TBuaiCmn2PWqL4L9nVmV+Ri5S0vx0aEmB92Qk/e6uwkT+ttXZOMrXoLu1uyGeM24mChNqQxxDdmk/coW0pkvu7EcNgICw40GF01X9nFKj4ymVuUr9YJ2ta+ZKjgG9DHCdaGUJ0TkG0yVYnjCZjDlAn7Qpher93/nCQ8skxkkZWWP4nwI1paw0hxPn
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdf787e7-d5ff-49c9-e699-08dbc3c34e70
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 03:46:20.6164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RcF1bNh4eOl4jGxEv0bp60Q242IgSsI0Su06BYC01r07/wYuCsVKpfy/Cin1ak5y6Vsf38DbuCO3j00jL96/oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4511
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-02_16,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=868
 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310030029
X-Proofpoint-GUID: Y_VlV0sYVZ9bCFZgru_qFr6iU9K3MGtI
X-Proofpoint-ORIG-GUID: Y_VlV0sYVZ9bCFZgru_qFr6iU9K3MGtI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v2:
Worked on review comments from David.

--- v1 ---
This patchset adds support for testing cloned-device in mkfs.
So using mkfs.btrfs both option -U and -P a new device can be created
to match the FSID and UUID of an existing device. This is useful for
testing cloned-device.

Anand Jain (2):
  btrfs-progs: document allowing duplicate fsid
  btrfs-progs: add mkfs option for dev_uuid

 Documentation/mkfs.btrfs.rst | 10 ++++++++--
 mkfs/common.c                |  8 +++++++-
 mkfs/common.h                |  5 +++++
 mkfs/main.c                  | 16 +++++++++++++++-
 4 files changed, 35 insertions(+), 4 deletions(-)

-- 
2.39.3

