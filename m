Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627096F6E8C
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 May 2023 17:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjEDPDv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 May 2023 11:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjEDPDr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 May 2023 11:03:47 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F112682
        for <linux-btrfs@vger.kernel.org>; Thu,  4 May 2023 08:03:43 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 344DiLGk012346;
        Thu, 4 May 2023 15:03:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=jwIQBJ/Dj1DqcG72GB2YgNNohhvTvfDqwS8feCttur4=;
 b=lhyUGk26vaX4iGJLEL+Fj+VwG18Z0ANpuaE1n9OYKKk3UoGLYamwd8ohbdwryzhlnMYE
 6DFF61Alv6Lo0h1lfPsx6XttNUjPDwRG0nw2kuysyNeKlH/IJVnH3/rqORuk0wPIVZ8n
 Hjkg1mEznpU0ahblRoDdiRYKTgsm55mnTKwz8th0723opgg27zJsDh65PKHRHZiu3Au8
 8JVvjdBwVJtXYQDfTsg7Tk2/229DR8Bl1i6ae6PoRu7mi7+RK2nZKUGIP6JjeWrPjUNo
 CICL0ucDW9AS+0fFIeLp9CE8UMWgylYX9jtJCdMIvnExLK/RiQyJZEAC04OqQxp8J7vw Sg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8u9d27q6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 May 2023 15:03:39 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 344EPIXH027145;
        Thu, 4 May 2023 15:03:38 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spew96h-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 May 2023 15:03:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DcPF6TdtVEjWHtsPxcZrtVysF7RDuyMaFreMLbYujvz7xX46W0YjbWLufIkKa7rMLYpQGoKIjKjcOXwXFsSexOGf0ZolFHQpBAzr9Fl2QY+6FNUtoCRwwBTGvHsF7/ifbFY8xMsNBUegy2F5iIxgcLbVF7uECX3P8rsIQcpC0swhBBCQLoQpu3j2xZ8lWHiUYx0j5BwVHuNaKclzELdreL2/+OYsySCM4R5xQueV6cFUIqtctdcNhT8E/frLNJvq9kTSK7F9ef63XT9W5kmlf2/+YfNJ3IZR8eZb6V6hgEbloWFjs14rxNJaZAs/Pf3m0X4YZuvlYqCFD9n9tEeoEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jwIQBJ/Dj1DqcG72GB2YgNNohhvTvfDqwS8feCttur4=;
 b=H/dLD0pnl9Eh81q4Di5xQW8PbPcFSmDqZLOldmZK3omqNGcJgsICgajlZQwvJmZe2M2og2aR/y9NJZt8QG+VE5unhKLmcHe93waBjTPdqGKH0MlRrjw18ay8fu96GEE+KF3qZYNRF60rFRzRkTBVUgIdj4Hqf46wVKne3G1pHEPiFEaRqqVum2Tbvb8CDSz4S7qTybIpr/EJCa40kUvazpUrmP0aqjB734rWn93D7toTBcXNfXlxHgNuVRaY81IGxDJNssTJqObZJv+1e1w1k8oo70OKQOh/cXYLRyEfurGJXFMKIsFL9JqP4DYO+763fqRmPq3sqQ76s0JzCVt8Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwIQBJ/Dj1DqcG72GB2YgNNohhvTvfDqwS8feCttur4=;
 b=MhtCoR6ee2GK3PFM3RV9MXxQHhH85qYsSPWgG8cXtwJcilUMBXTXRLo6vVsZ7oIKaEvo5e75192iEBFZ64FbL2IEsKngHcPMYOvT1gUsMHuhIcxK8oCSfvLZbIuOfLfLv7AWG0SBl6yILaO8KrpKop8L89hmUOOK9Q7prDvnE3M=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA0PR10MB6892.namprd10.prod.outlook.com (2603:10b6:208:430::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Thu, 4 May
 2023 15:03:27 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6363.026; Thu, 4 May 2023
 15:03:27 +0000
Message-ID: <62a4df27-445a-057b-0679-9710f1d31802@oracle.com>
Date:   Thu, 4 May 2023 23:03:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH RFC] btrfs: fix static_assert for older gcc
From:   Anand Jain <anand.jain@oracle.com>
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
References: <85f3af8298a4d7b6e40045aa7c6873d7ae1bc311.1683206686.git.anand.jain@oracle.com>
 <20230504143321.GF6373@twin.jikos.cz>
 <e74a3f59-0ee5-b2f4-5377-cb48d9d170fe@oracle.com>
In-Reply-To: <e74a3f59-0ee5-b2f4-5377-cb48d9d170fe@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0004.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::22) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA0PR10MB6892:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d076a0c-2b1c-40d7-89ae-08db4cb0b712
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8bGuzIvmiRFWtZxH32rWCclHGV+y/aanuQbeN0hDv27UOeHePqVJq+j4q8ixH0C1csMtwk2Lui802FALHQGIp5fMMcs9JunBuovUgwehArQY8sA9eGXRPx6TsQg2VDP/pZhk8M+SCKR+15xvX9UdOWGomAkX/X6XM5/QMShi7yU3I3gYmM6HKWZp7Lm9h1CdVeCM4Ry/pjexha3jfLBywhmFwv1PTdUZQuJgqevRX0RkrF+SsA8ODPiGVoH8Bt/adx+G7ExuqzWh0sUXTo2gIpILeg/Mdzk2mB4jF4DuGs6VXSoyo5l1rvaNDkih33Tgb5YLylKW6FzA0cY4eVBLuJ/BOdWDkR4qJWIPhje1yCOQVNK+3PdSAilJSCfpYDb8ao74y4tIAxnAqP0jVIzz7isy4CWxF1U8kLjtiQS8ni5gW6i3RtARavMlw2qhb0/IaUxKFN1Dj2KoRaLdcbxyuhAFOjRuWuwku7JFmrBBpzURCcu9uT4cMl32AzdRsFrYyUD0f/trHQw1W1DeHvBMf3bZHrm54XP4vVuTzFe67x9GXhkOi6k3b3oAWwYPLfPvWgORu33S9Du+mZhkL0QEyAPbrHiAJJzBxmoCi0G5QLfw39gODCnr53lvLdoH6O2YkIyabB1c4A70k9huFU6HEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(136003)(366004)(396003)(346002)(451199021)(6486002)(2906002)(31686004)(38100700002)(83380400001)(478600001)(2616005)(44832011)(53546011)(186003)(6512007)(6506007)(26005)(36756003)(5660300002)(66476007)(66556008)(66946007)(316002)(8676002)(8936002)(966005)(6666004)(41300700001)(31696002)(86362001)(4326008)(6916009)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGtpNzN2VVVDVFQrbHV3cHhWY3JrdWpNenJaQjRKdytDemVkQ2kwcmtWaXg5?=
 =?utf-8?B?Tld5M3ZxZ1VMQlJBV0ZWd3lyRVpjcXpQUSticGJhbkNrOExmWDUrMzBGOVpv?=
 =?utf-8?B?R3Z3UVpYTHhZRCtHcHhIZlNuVnkvMElMZzRTaEhpbTY4SDFMYlNycmpaYkIr?=
 =?utf-8?B?T3B1RnRBTUJzcGNIRXNFTHF1TlJDN2U1bjRJWnZQcnZ4TndKQ1pFN0JjZGhE?=
 =?utf-8?B?cVVER1A0am5YYTFSU0NJU1lySlJvNUUxeCtudzg3ak1uYXNnNmZ2eXpEUWJp?=
 =?utf-8?B?VVVoUEtPQVpiQ28zSGFwekdiTGZDMGthdklkTWpkQ0RkVjBZYUZjNTZ4OEJW?=
 =?utf-8?B?dnZ2OEF6S1FCVDBmdDQ4b0RuWXUrYU5sSlpaUlBXMFRyWDRPZ3Q5dzUrTk5h?=
 =?utf-8?B?QkpNQkt0cHMwVjNnZTNTTWpaYytFMUdaVHlRelA4eUZoeWVhK3ZKZ0ZUQVZv?=
 =?utf-8?B?MFRWV1R6V25jUVJSSVg0UVdsVG1xczBRM1U2SmJ4TVZHSUJhVU5YRTZ6bXZ0?=
 =?utf-8?B?ZzlYZUJld2o4TVExZ1oyRmtkUkx0QlMvTlJpUFY2L2ZzUWs2eVZ6NkU4b0Y4?=
 =?utf-8?B?aDZuSXRhV1ZhRkZVQ2tVZjNyWlVaSHdteTlFZnBTaURDYkViWGpQeVF6cDJl?=
 =?utf-8?B?aFQ0MStIbHlaQ1oySXdvOFNVY3FrWGhGNFk2K0h0RWV1aHcyZnhUV2JjMWho?=
 =?utf-8?B?VkpWS1RYbHhUVFN1VnBCV1VqQkpkcHcrRDRGclJVb3QyaG1oZHdlQTUwTFN1?=
 =?utf-8?B?d2Nzek50TkZxb1ZTZ0hwSUdxWUZLaldHK0FiVUtSNXhKY2ZHTk9VZjM2Y251?=
 =?utf-8?B?OHE0MlJhcDAvMGd3Q3lrWDNXcG84WkR6c3ptb1JrQmFtZU5BWTVod0ZYOHFw?=
 =?utf-8?B?NjRaODFxeFZpTkpneWJsdmVoUW1IWGlNV3pYZktqMVZxYnV6eHVNV2s2WmdN?=
 =?utf-8?B?cW5pcXRoNXNzeUxiRndpUUljYkFhTGNLMTFFbk9GL0l3WDdLak05L3MybjZP?=
 =?utf-8?B?V2xXdE5jbTJxNjA2aGdXV1ZGeXBSb25SWGh1alEvV0t4Ti9JN0lNbEViNTJI?=
 =?utf-8?B?eXhNaUh0d3ZwbXlLVUlPQ2tReWNwdTdWa0Z3Yk0zaVVGOGRQdTFXZW1PbVpY?=
 =?utf-8?B?NG92VERlcVhnVHk2YTI5b3JBbWtmaWowb0FLdlRtdUUzbndKS1JRd1FrZlNP?=
 =?utf-8?B?eVZlTDNvVUtULy9kajFXVUI0aHlBVFZORDJBTU1MRnpkY0pSaDd6VEVuSTFM?=
 =?utf-8?B?SGFnMXpYNlIxaWF1YTFVTFV2M3VaNWw5WFJDQWhzREwrL2Y1YnZuSks2OXZP?=
 =?utf-8?B?dXFCTHl3SnJ5ajZNYnVDNFgyek9LOGpPUDFQMGRJNTh1YWZ1a1F4UVQvWHRv?=
 =?utf-8?B?eVdwTzB2MklUSFQwdlN4V2FUanpmRm5TYmFtTU9xZmtYYU01RlNPZ3FLbTd1?=
 =?utf-8?B?eEFRd1hTMDFiZVcrUzl4a2tCbVhVWFlRWGJTbDN3TXNPS2NITWViWjlqeGtv?=
 =?utf-8?B?TnBaa2MwMldOQkVKemhXWVMzdytLQ0pEQnhlU2doSWEwWEl6cnNrZkMwb2xD?=
 =?utf-8?B?aDBnM2JqdTdrQXBiSDlXc3BYbDhZZmtPbExOTkd4L2RXeFF6ZHlaR2RvQXNC?=
 =?utf-8?B?Z21KYXN3TW1XMURWMWZTN2tYcHpHN1dySUsvNWR3dXoyMUJFSG5DUjB4VE9O?=
 =?utf-8?B?bXA4QzVFM3htekJneGpEYW1GUUJISHUyNGJKNjVsUzVXS3ZpcktDeHIrT3pR?=
 =?utf-8?B?WTBodkwzTnNMdHY5eC9xQmdZL2d5dXBFQ01JYnpWaTJpWTYvK1Q1MU5pQjdl?=
 =?utf-8?B?djlmTFZuWjRBcVRpVWxORTFIdUQ3RHlpNThHcU9Sa01kOHpyZlJSVXY3UDg1?=
 =?utf-8?B?TTNjOVhjRTZnQkJ6NCtyMkY5cDlWM2VzbzlNZ3laT2xNZ1NyL21mNHNqSFo0?=
 =?utf-8?B?d0tZUmRTS040QWIxc0pYVVNXTmliQmVnOGtLankwZDlYUlZhMnIydDFORkdK?=
 =?utf-8?B?NzhiNXBNNTFEcC9wUys4NHB3Q2duWlRqZzE0eHVkbm1BeExCbCs2WC8yNHBC?=
 =?utf-8?B?Zm5kYThVTnVvMzAySzFZOTU3K20wL3JsN2dTcFFHWlk4TmFUTDdiQzcvc3Y1?=
 =?utf-8?Q?mtODoFRmNoMzInTQDzef4Z0A3?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YbtPXj0HOPJ0sPcROqHYXR4V7u4I9DSDBAfub9sTJ4iZWnUYje9RhVChp6Ac16O8q8gbYkboQ/40wpE2JzCXy7EO7Br8D1z4sPBwG0SgzZLHv5fX2fF7i5DpCwcL7WgVaL27ooiBN0A0BKx+OK3B2XcH41eXcR+hyOadJgyqANykl7w25IkWpX6GCuTJYtbIr2KzT54vInYNIrhHkI975yuInZdftsoT9xGzQamHwabDfFR7AcfEzr6TZ2ZabON1/jI7Y619Nd21ho7Q/bK4qktylhUyerGR8jp2gNF6StbKEV4+bNezrf+DqPINS00HXJr+AlCjPkwIHeKiOud5G63yuDJWgofmBEEeuGOAq9U1QbOuQCm/bP0HNdDxHWIOUfrzFKb4J3hLt+vvbRVDdWnshmnMEkJJhd/tS+GSGq8jAPQfgm0CdBSF/l4qpwQMtKmxFNUpFcxnnxptD0Z1b0Qn259hz6PtAhqBV6uikWx7RH2Hri+Qeo5TLw5u/IbztaqyKhLTBnQ1rTa9Lvix0PRrzAF9tkTWn/JIZB/SIZjV2pSTsVpEmv/eOPvMlzkpHKVzlnNj5FuUy5MQh3uNFVKW0gnQH8tPPexbT0yHrtskO5Mt8CNjEpH1YBiF/A/zqpJ61MEdvcaa/RZx1kUE3GG7iLW/REy08hph85TSl9MKyrVgrh82qvnzgZfCHNiF0gJ03qmbknyFu9Y2GB4DdQhmgPCjKH9By1NLrxr3I8y+QzIioZQCRxFkjmtIyOlrQ0Bw/H9CWJ83ZTkEds5qFA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d076a0c-2b1c-40d7-89ae-08db4cb0b712
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 15:03:27.5319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HRiugK066lMdoDUbdMwnwuGItI6qxMDLJmm3nsZ08nZdB2uvp1FKQIJukZGYYP49XxvB+ILI5Xg2cPYHQVcx8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6892
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_10,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305040124
X-Proofpoint-GUID: PzBllcwdqc858p_CCfnUECViE8N5z-SC
X-Proofpoint-ORIG-GUID: PzBllcwdqc858p_CCfnUECViE8N5z-SC
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 04/05/2023 22:56, Anand Jain wrote:
> 
> 
> On 04/05/2023 22:33, David Sterba wrote:
>> On Thu, May 04, 2023 at 09:56:37PM +0800, Anand Jain wrote:
>>> Make is failing on gcc 8.5 with definition miss match error. It looks
>>> like the definition of static_assert has changed
>>>
>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>> ---
>>>   fs/btrfs/accessors.h | 14 ++++++++------
>>>   1 file changed, 8 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
>>> index ceadfc5d6c66..c480205afac2 100644
>>> --- a/fs/btrfs/accessors.h
>>> +++ b/fs/btrfs/accessors.h
>>> @@ -58,29 +58,31 @@ DECLARE_BTRFS_SETGET_BITS(16)
>>>   DECLARE_BTRFS_SETGET_BITS(32)
>>>   DECLARE_BTRFS_SETGET_BITS(64)
>>> +#define _static_assert(x)    static_assert(x, "")
>>
>> So the problem is that the message is mandatory on older compilers?
> 
> 
> I couldn't confirm the GCC version and static_assert changes, but found 
> the kernel wrapper in ./tools/include/linux/build_bug.h.
> 
> 
> /**
>   * static_assert - check integer constant expression at build time
>   *
>   * static_assert() is a wrapper for the C11 _Static_assert, with a
>   * little macro magic to make the message optional (defaulting to the
>   * stringification of the tested expression).
>   *
>   * Contrary to BUILD_BUG_ON(), static_assert() can be used at global
>   * scope, but requires the expression to be an integer constant
>   * expression (i.e., it is not enough that __builtin_constant_p() is
>   * true for expr).
>   *
>   * Also note that BUILD_BUG_ON() fails the build if the condition is
>   * true, while static_assert() fails the build if the expression is
>   * false.
>   */
> #ifndef static_assert
> #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, 
> #expr)
> #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
> #endif // static_assert


Closest I could find is

https://en.cppreference.com/w/cpp/language/static_assert
"message can be omitted. (since C++17)"


