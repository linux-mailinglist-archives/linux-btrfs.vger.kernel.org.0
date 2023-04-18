Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854856E5827
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Apr 2023 06:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjDREmu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Apr 2023 00:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjDREms (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Apr 2023 00:42:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306632D47
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Apr 2023 21:42:47 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33HLSvCg006490;
        Tue, 18 Apr 2023 04:42:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=qXfPpUGOhDNJaJoEZt/3TxZRoQnUiyzs4EbMeLdo4f8=;
 b=VrKDUyt+4lhRlfoTD9y8Rxs2ZgpY6YGjT02ryziMNQQuWsVdQG93UiT55NpyQvGZEz8X
 NhYddr9nFrLpcNsa7qoUGsOPTNeSJV0+lpl0ebaHB57xCcjhkfTPGZJAT3xSefFKtY9r
 Vgjtus3GwcNKD3OyqgO1XY4t/+u1/AHmVBAk8nKdXbBSxPGygifgz8ww2PvrywGPJlgV
 GI6r7tJXyDRTT5rlkUzAXAtCUe6pRC1q9yU1fiQfJm2YhYGus/7ZQvfQRAYwL8z09/3F
 WxHro+sroIMyeufRr3Qt49M7IGUdxdLiEVrAI7/VGY8zmfBRFd++HNloZ0UJ9x+lOauG 9Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pykhtvpat-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Apr 2023 04:42:44 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33I40pUO017542;
        Tue, 18 Apr 2023 04:42:43 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjcb8s8j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Apr 2023 04:42:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JIK5Pdg0KpBy2BmmU+HJWlOiFRUrNLNB4WEa11DMm1NnRZijLujZ8NlwBGHrbgfQVmCgeOi8LYrubVwsaKVHWxWJJfDJEL0pWXW1SDgn6ik2Q9i77hR2DbtVTit2Z0ZNdRpUux0Y421+jQSVBQ3U0oXLsV0tedrMEKtWRNVVU1LhWDXUrvLesEtLIoG85lOZCBfOo/NXt1sTn0Yfn1t+8RMcClNuMVhLKAtQ5ngGVEZCwkE8MR2PbeVEq3OUbi7ftNfiHE1wzirsE3rHeeNEUuqOcC9YH40sRtyTrjUkk1ioYDQ5f8eQK7087nCo6IeVhiIFgYla3ZEyLpw9rgD/oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qXfPpUGOhDNJaJoEZt/3TxZRoQnUiyzs4EbMeLdo4f8=;
 b=SqJAGd8rUyUmTqtTSzujFz0+7VgZ/V9+ywdQbVdfxlqwdGjrCgHU2toquak7+vmZ5rVFw28+puGcPNy2uWgbXVy4dOxtuUrwfyeT+oAx6ZXZWQ2I4Z0D+e8hfj3euLrRH0/MEHPEdrnVVRLgbTxSTDWdYlhgvHQMLMuFNxXNXKvNw9p/epwE4wvOLhD6KH2mVUTeiUR2D2KaiJ2BzPSRYK09ony5EFHFnMdEE2V4XJ9MhSvYrsx+KPZvS0bkoIPNdbgJm45DeiKALu5cpmZwSGS/fn9sqnplJasiDW5HycVzYNK8NaTbmGEwBOx4UNuaMWWe7bG2zdl7Yon/K1Hg5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qXfPpUGOhDNJaJoEZt/3TxZRoQnUiyzs4EbMeLdo4f8=;
 b=IDQWGE2hsAqe+i6IKwi3yCwbA5aVC14MELjGhFj7v0Gdpf8uQqgEgNVxPrbN0isEehA5hLLlNuEUSna+aDqQq6G6iZAsj/b4+8oMgNowyh/xPkLohj/h6liDiN77HW5IkOlMVoumSZqSsmiOZOswt7ArYVosXVBTOJW7vtfAfcI=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY8PR10MB7289.namprd10.prod.outlook.com (2603:10b6:930:7d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 04:42:41 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6298.045; Tue, 18 Apr 2023
 04:42:41 +0000
Message-ID: <9bb5f4ea-717b-2365-652a-01b130452118@oracle.com>
Date:   Tue, 18 Apr 2023 12:31:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] btrfs: output affected files when relocation failed
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <aa446804b679949a1bd77e653a205408af43048e.1681780522.git.wqu@suse.com>
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
X-Mozilla-Draft-Info: internal/draft; vcard=0; receipt=0; DSN=0; uuencode=0;
 attachmentreminder=0; deliveryformat=0
X-Identity-Key: id1
Fcc:    imap://anand.jain%40oracle.com@outlook.office365.com/Sent
In-Reply-To: <aa446804b679949a1bd77e653a205408af43048e.1681780522.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0082.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::12) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY8PR10MB7289:EE_
X-MS-Office365-Filtering-Correlation-Id: c8034979-68c2-42b3-ff58-08db3fc757bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZkRtNkFVZThKK2NhaGlnUE1kQ3ZGbEZnUWJPaVZ1dStuVEZoUEQzYlZNc3Ra?=
 =?utf-8?B?ejFHaitERjJZVWtZNFBjck1KaXJBZUdrRFlodUxweDBvajVTODA0MFRHOUFV?=
 =?utf-8?B?UnlwNGkwSVljN285dTJheFNYWnJONlNIYWwrQkUrYitRS1NVQm1uT3dkVUFs?=
 =?utf-8?B?SVc3dm52NUFVQUhqMzNsSXRCdDRlZzNBekNqQjFHNkk3T05FV2htRytFQTJG?=
 =?utf-8?B?RzNRcDBXei9aa2F2Z3JqSFRRUXJ6Zk5zM1U4bHpvTk1qc0wveHRIV3hpaDFt?=
 =?utf-8?B?RjdqcUt6MTkvVi8vcjI4UW1zaUlHVW13RUtzUnB5cFE5WThyK3RtQlBpU2FV?=
 =?utf-8?B?blAxa0QrRTFvQnJyN1FEbFErMW9TWTVadDFPZk5FMmxNYVdzQXRhNk1id3VZ?=
 =?utf-8?B?TjlsbVhWbHNEVUxYdjRsaG9ZdFJ1SHdCWWhSK3lWQmlDb2d4ZzNIb2FFMGRH?=
 =?utf-8?B?VEQ2QU0xd2tSWlNOTDcvdEVDdytwMHRQUFNlcjRDL0dvNjZpLzBXcDNycFU4?=
 =?utf-8?B?dVdCUnZqUy9vYjhBMW52N3k2dWhhZGk5QzZnTHhGQ0Z3R0dXM3ptT1NadDcx?=
 =?utf-8?B?bnZNQ1czT053eWZIZEZPRmNtSVpaaXBCTUIrZmFMNnpOWndiNm94WU9RR3FY?=
 =?utf-8?B?YndwWXFGaE1PZDZIYnpucXRTRDRRcmVpbk5SMElPbXhFeENjdDk5eHhnZUtJ?=
 =?utf-8?B?eHVLMDNMNnhBRGhERlhZZmN0b205N1p3NllIM2lOWks1cDREMVNyc0NOZG5v?=
 =?utf-8?B?SmNId016MzgyNkJXeWtoMHJ5OXNUcy9FMWZiaFkxejNpbEk5cE9xa3BOVHZI?=
 =?utf-8?B?YjRsZHhlaGJyUXlOQjVUaHRuUS91RkgzMVNJdmNFNmR3cDVzMFNDcE1GQkRz?=
 =?utf-8?B?d1VpVThBKysyRWRpRk95ZTFINGVhQnZvdGRjZFc3YzZpNzF6Q0x5RUREN2c3?=
 =?utf-8?B?TmFaamh2RzQvQXpkZUMwTVFackwvV0dpY0pmd2twbndHcEJyc3RYaVd3V04w?=
 =?utf-8?B?ME9MQ0pzWFpRRU1Oa1ZwMlQyTGJ0S2ZxZlVOakpBK29XSEZVRzZOSC9KcS9P?=
 =?utf-8?B?SXdXVDZVV0pQT3l0ck5LR25iZ1ZQMWptVTRqQ3dQcGdScm5XeVNpYkIrbnNC?=
 =?utf-8?B?Z1NEM1FmalN2ZTR3dWlvRWk0UXpMa2V2Z0ZpWXJLSzUzeHE5TlRuSXBVSGI3?=
 =?utf-8?B?R3lJNXI3bFRjSUNGWWx1YmUzT0VMM0lycFVXb2lTU2ZFbHZtazdVWjBrMVVv?=
 =?utf-8?B?RnRLcGdPdnVwWlNreTlCRDZBWG5YQmVKM1psbkFadEkvR0YwaTl1VmErWXN2?=
 =?utf-8?Q?vup8pkzan4yROt2LIMT4KgpOe7d9m5sTOD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:OSPM;SFS:(13230028)(39860400002)(366004)(396003)(136003)(346002)(376002)(451199021)(38100700002)(6506007)(6512007)(186003)(53546011)(83380400001)(2616005)(44832011)(2906002)(8936002)(8676002)(5660300002)(36756003)(86362001)(41300700001)(478600001)(6486002)(31696002)(66476007)(66946007)(66556008)(316002)(31686004)(21030700004);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2xwdVEvWk9qT3ZFMG1ET09Za2FoOW8zbldQWVoydXRLcE82MVF3V2hrZ1Vv?=
 =?utf-8?B?d0JkY3FXUVVwY1RRbEwyRmV5YVZ2My9GbGY5Zk5JQ3dFa2YzWFh2THVLak5j?=
 =?utf-8?B?Q0tJb2pnTEY3NzZ0ZW9wTUpxRGUvOXdjL1k2QjIrZFZKSWd5L2RkSVVRRHFi?=
 =?utf-8?B?NE5NQkExRUZndklaRXF3a1FpY0J4SFFudWFWTGxJNDRQTGh4U2lqS2hZanJh?=
 =?utf-8?B?REQ4bDJzZXJPMUZ1c3haRTgwN0F4Sm1GQmZNam85WWoyR1FBMERjUzVBOGFE?=
 =?utf-8?B?TlNHRUFRWDNDMjBXK25zcjlpMEEvc2FadVJDNmJCaFo2YktINUdtaWxWYlN2?=
 =?utf-8?B?Qml0UnVpb3pPQ3pEcVZNTzVZKzAyZ0FKSmx4cjZXbU1BZjhvNC9abnJvL1pl?=
 =?utf-8?B?QVg0L1lWVE91eTNONStmRllGaU9FdTR0anMrZWt4ZUU0UVJDbGpISUMvMDkw?=
 =?utf-8?B?cU12VEdPN1I1N1l0dmcrMjNXUFpjQTllbW1zaTZVSllVcEUwcENSdnZSTWth?=
 =?utf-8?B?eGR2OEFUTGtzVklqM0p5bmVhQTR2ZU40bklGZ0RLTS9BQ3BDZHE4RGszOTAx?=
 =?utf-8?B?K3VzbG00MGlJanc1dGw2SllTa0k4dlE4MU93T3hzTmFUdmRrOVBPZ1g4U2dN?=
 =?utf-8?B?aGtKc2NPVHN2TG95K0RMM0RTd1d5QjNDZFRKT3FmVG02V1Z3WmxrRS9pemxG?=
 =?utf-8?B?NkdnYWlodWlVZnY0UHQ3VWhubFpqbjRwMVg2V0h3cGlJMk9UcEl0eEFXWFFJ?=
 =?utf-8?B?NG5PaXFzL0FYMERyNW5jL1hUZXNnTDY4eWVldXpramJmT05IbmRwZUQrNldh?=
 =?utf-8?B?eDhZY3c4L0tRR05FZ01qazA1TUNmVURRQURsYUFxTDZwRFg1Wi8vZUtra0kv?=
 =?utf-8?B?d3VDUDMrelE0eFlxenJSOTZla3dLQzFyY093Rkpjc1gyWk0yQUczZlZBeW1Y?=
 =?utf-8?B?ZHJxY3hUWXhxY2xyME8ycFh3YUloY1BjazQ2dHBhemdBSU5GVXRMSStzaXhQ?=
 =?utf-8?B?TGV2Sk05ZjhMVndrcmZETjNDdTVTMDBGd09rUU16U3l2cWIwd0VIYmMzTFgv?=
 =?utf-8?B?Rm1ISWd0U2dVMXR4Qk0waGgvNlpBWUdCaXJFN09EYTcxaytUcVMxOFdocHZO?=
 =?utf-8?B?OFZkSVFDQUxSTUdnTnZtMHdyQW9EdXorNXVNclJUOGtLbXhFRGttMmNhQldi?=
 =?utf-8?B?bXI1WVU0VWl1dFUrWmpIQ3VMeUpsVkhvai9neHNCL0RXalViUytUSWE5Skk4?=
 =?utf-8?B?OHFEK1ZCYkM4Vnl1WEp5OThVN3BaVldvQThrOUNPKzRjRVBsbEpYblFXVGhy?=
 =?utf-8?B?d1JtMTVzQnAvR0F6TmlSR3d0MzB4dUhFd3Yya0FYcUJPbzJ1ZGpCY3gwNlYv?=
 =?utf-8?B?MUY5aytmcExiVjc4cHhtaHJ6cjBFeWwxdkt1RzBvUXVPNnkyUFpxb0gzTWxC?=
 =?utf-8?B?RTIrWVBVQ213VmNrdGVXS0N1d1V2bHEzS05VYTNLeEtNYnVwdDRKME4zeUdv?=
 =?utf-8?B?aTd6ckQ0cjMwTE53QTBMWWRWazVZNVBjb2c4OEttdk1PdDVUdFRpQmthV29x?=
 =?utf-8?B?N1cvdTI2RGNTSklOakZ4TW5qUGt4YVZCM2lFZnBGMFhDUWpTc3Q0OFc0NDJi?=
 =?utf-8?B?S2V3bGdyUWgraE5xa01Mc3p6V2FpUkZOY0k3NS9VbzMrTlVvbG1IR25UeDc3?=
 =?utf-8?B?VHg4U2VpUlE4NmJncXFmdEgwY3BEUVRhSHUyMFZ3akJBcC96TlBneXQ1WE5P?=
 =?utf-8?B?L1JQWWdtWDZDaVYyTVBqekNQeitrQ0ZrZ2RNOXBYVUJFdVplbW9STTZmOENL?=
 =?utf-8?B?dEFqUW1NdEJ6SEw0RlIxT3pJMWRFbk9mVzVxTGNzWFEzYWYzc3hzdjZEcTNC?=
 =?utf-8?B?QmdMZU5Ed0JNb0UwbEVqUXBGTmZDanhlUHNIVjdmZHhITkNnYjg1TE1XNndl?=
 =?utf-8?B?MGRKQjBlMU44U0c0V2lxUm9zbE50SmV6ZUloR0k4ZjIxWG5EWFEvR0JKeTFC?=
 =?utf-8?B?OWtkdktjY25BNS91b01vWUR5ZXAzQ0YxY0ZwZHEzVDlhMzl6QnNGVnBrOS95?=
 =?utf-8?B?NG5WV0g2VUUyK1FOUVhteWFqSHcxVDkybHAvbXFkcWNtNHhVUmt6NE9XZTJk?=
 =?utf-8?B?bU12RVVvdEFlWDVmbXdnYmRPc0hmVzlGaXFxc3R2d0lrZ1pEdEt0V3RuYmJI?=
 =?utf-8?Q?KV1C0thhQDTa5qX2oKRundGKNA6AO3E6gI/rG83Jv25r?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: w019394/GG27zcqRpw3J6dLCade7/0pqHCTOZQOLJdz0xHTF7+eD1SPmk+v1h5I0MctyRD4mLCUQrtDzHWgchhgMiDB6ZgvtmIvC8yq6X+dP+KMN2fpP/R74ialvDowhQ/734WeNX7VYP0CdJHd6oexfazGRobJTWPz1Sbsywwm6AGX4XYCOc7GczuaQ0L2gEPQwWFMnUnQZJD1Sv63QPVYoD/DtzDhHLvu/TkJJYIJAVzwVyHLcef/wxWIme/oRC9QgCGEtpN0GBXKY8Xe+LGs/sSl1kM4Ro7uhYIeuk7KKjEIOmTpZLycq/3Ak/kz/IU9LE526d3S0hz8IlfihPBsjB7gFHkgxqpcLsqNLAqDU8YUIXqG9IfeMIABq4DmEw5LrZrO2MKP8EIpSvBufOdKBHY3G+o4cjXdOW2NTBS03nNU3BMdn3Yif0MQVfOW49jSSQZGyU1cCvNkJoExttyO5aq8c0NSabPX1pKOngpccBz6saFwyT2WX0A17v1ujOauqgAikUX8FMMwhd2cCY5I6vQvBbqivW7xHo7YTt+UcGs+TaAPAIEK20rMStTJ46U5VHzugImxI3uqbtb9aIm19AtuB5OvGZo+cVjTAhXJutGUd2bBbJb5RzOcKW7rlLbg9ZcM0Ul+1nmJ1a9KEtGiFWB/dZnuITT+28VYS/k65BXogRW1pcm0b/fwkAmkasZxW8gyQzKMKQqzMMJr+8HJpb4LNwKpb3zaqSq5aXKpPKnaB2FwaWZbNeh0BA4L5B5dGIBI4dWr8+VJN4BGC2tDYlGlbnSuQZ/Tq4MtCu4A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8034979-68c2-42b3-ff58-08db3fc757bc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 04:42:41.1761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7JRz78TGUkNzFAtNNd12eeQcQRkibwvsJyCK2UvDrc/F+Jihy4F4I7kRSBACCMPzlKVBpTbm2Ykq0UuBDBSuKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7289
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-17_14,2023-04-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304180042
X-Proofpoint-GUID: bTk3JWB4OsaxbzZRKBxfZwPioV_JK1si
X-Proofpoint-ORIG-GUID: bTk3JWB4OsaxbzZRKBxfZwPioV_JK1si
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 18/4/23 09:15, Qu Wenruo wrote:
> [PROBLEM]
> When relocation failed (mostly due to checksum mismatch), we only got
> very cryptic error messages like
> 
>    BTRFS info (device dm-4): relocating block group 13631488 flags data
>    BTRFS warning (device dm-4): csum failed root -9 ino 257 off 0 csum 0x373e1ae3 expected csum 0x98757625 mirror 1
>    BTRFS error (device dm-4): bdev /dev/mapper/test-scratch1 errs: wr 0, rd 0, flush 0, corrupt 1, gen 0
>    BTRFS info (device dm-4): balance: ended with status: -5
> 
> The end user has to decrypt the above messages and use various tools to
> locate the affected files and find a way to fix the problem (mostly
> deleting the file).
> 
> This is not an easy work even for experienced developer, not to mention
> the end users.
> 
> [SCRUB IS DOING BETTER]
> By contrast, scrub is providing much better error messages:
> 
>   BTRFS error (device dm-4): unable to fixup (regular) error at logical 13631488 on dev /dev/mapper/test-scratch1 physical 13631488
>   BTRFS warning (device dm-4): checksum error at logical 13631488 on dev /dev/mapper/test-scratch1, physical 13631488, root 5, inode 257, offset 0, length 4096, links 1 (path: file)
>   BTRFS info (device dm-4): scrub: finished on devid 1 with status: 0
> 
> Which provides the affected files directly to the end user.
> 
> [IMPROVEMENT]
> Instead of the generic data checksum error messages, which is not doing
> a good job for data reloc inodes, this patch introduce a scrub like
> backref walking based solution.
> 
> When a sector failed its checksum for data reloc inode, we go the
> following workflow:
> 
> - Get the real logical bytenr
>    For data reloc inode, the file offset is the offset inside the block
>    group.
>    Thus the real logical bytenr is @file_off + @block_group->start.
> 
> - Do an extent type check
>    If it's tree blocks it's much easier to handle, just go through
>    all the tree block backref.
> 
> - Do a backref walk and inode path resolution for data extents
>    This is mostly the same as scrub.
>    But unfortunately we can not reuse the same function as the output
>    format is different.
> 
> Now the new output would be more user friendly:
> 
>   BTRFS info (device dm-4): relocating block group 13631488 flags data
>   BTRFS warning (device dm-4): csum failed root -9 ino 257 off 0 logical 13631488 csum 0x373e1ae3 expected csum 0x98757625 mirror 1
>   BTRFS warning (device dm-4): checksum error at logical 13631488 mirror 1, root 5, inode 257, offset 0, length 4096, links 1 (path: file)
>   BTRFS error (device dm-4): bdev /dev/mapper/test-scratch1 errs: wr 0, rd 0, flush 0, corrupt 2, gen 0
>   BTRFS info (device dm-4): balance: ended with status: -5
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

LGTM

Reviewed-by: Anand Jain <anand.jain@oracle.com>

However, a nit as below.

> +		btrfs_warn_rl(fs_info,
> +"csum failed root %lld ino %lld off %llu csum " CSUM_FMT " expected csum " CSUM_FMT " mirror %d",
                                 ^ %llu
> +			inode->root->root_key.objectid, btrfs_ino(inode), file_off,
> +			CSUM_FMT_VALUE(csum_size, csum),
> +			CSUM_FMT_VALUE(csum_size, csum_expected),
> +			mirror_num);
> +		return;
> +	}
> +
> +	logical += file_off;
> +	btrfs_warn_rl(fs_info,
> +"csum failed root %lld ino %llu off %llu logical %llu csum " CSUM_FMT " expected csum " CSUM_FMT " mirror %d",
> +			inode->root->root_key.objectid,
> +			btrfs_ino(inode), file_off, logical,
> +			CSUM_FMT_VALUE(csum_size, csum),
> +			CSUM_FMT_VALUE(csum_size, csum_expected),
> +			mirror_num);
> +

