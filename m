Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDA0402267
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Sep 2021 05:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbhIGDIE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Sep 2021 23:08:04 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:4702 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229797AbhIGDIE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Sep 2021 23:08:04 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 186MTc97029587;
        Tue, 7 Sep 2021 03:06:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Xpyyry+WRuikWrAiPAU/rj/EEZVpKQYATgMnRA8+hLs=;
 b=Kmj+VVoJuqrgQ480Yg5/V+K4Vs9kR1gNd2r07WjZhcVLPTTGf1z4qiufS/P+NT6rs8Q9
 LhIrU+LUIsWWN3sah9prjDVwKOZ4hpYLfNUwtgDvbXW2V9c+prxIvKwfOn0SVY/MjQli
 WAmrbio5TLxTXpvYt6/+YwjD3Qeu56sWky3wz7h2Doqlj+Sql8LmW1Hi7I8+sEITXBXf
 vyRY1ivd38xQT4Vy+RArA7FADEKbI5Bq5ym9Po52lAipjLTXtEQSeSS9M0URI0lKL+J/
 FKVV+JzMNlt6BoqD368jKdlnosf0+V1z55pE56B6E8on6BqJYud/iZU6ydKZFleDITnx zg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Xpyyry+WRuikWrAiPAU/rj/EEZVpKQYATgMnRA8+hLs=;
 b=UBagKe+wyPGHIeQuKMEejCI7CE1Ib/m8BHPHdge6ytLBcOkHdsevhrXlkEM0UYw9X/QI
 WFx84/M4tpKZhGhp/HgdUBB8P4GfbHUzU34kRzjrJWa2pAA9kJHzsDO1eD7OoEBE//DV
 tySay3mWOy899AYLmhxflVEGN9VgKM/wjdOar2QGUwB4B+isCxBMIX8OU+bNrKFFetuS
 qw8YkdClVAESDTtuaWQnjZBBXMz5H3RZQVcHB5xGKOKDfiNgKmHXxSVhJgUEDXbQekf/
 Q7GADoM6udMT61b81B9Wf+9Tri4kQ3q+nT5MBWGpOYcwvWmTzEYX1l5PtuMKaG2UJUCr PQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3avy763175-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Sep 2021 03:06:55 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 187366dv158451;
        Tue, 7 Sep 2021 03:06:54 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by aserp3030.oracle.com with ESMTP id 3auxucy3sx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Sep 2021 03:06:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cwqi5IIlQXBHWRXwvIMda0fcozXBHBDs4ar/KfCeWPDlS7mgbKs7FPZwRqL8lrQ4sXXEkIhBj3VQ9FNYr05epHuQjo6ugHyjJ1Jtfz/TGd5wVnN/VDPkPHxLbeb6q86qwc/A1N7j1za6aqYWeZxuCF1tiF08icsw2CfUaugV0b2sH5H0dULubKSpxaCvWqAkESz9/gEHOGlBo0R1qpp7ptOnzR8X6bdUfdgPMMEGknrIfFOmZq9zlccpdmDR/AO/jlBbxq/hzE1sO+rwz4/0S0QkkrTTLHLT0vj+m2KhHxuNrAO9J7y/iVfi4rwDE09x6fIhdh8VTB2bqx91QaCTXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Xpyyry+WRuikWrAiPAU/rj/EEZVpKQYATgMnRA8+hLs=;
 b=TK6toao8YDtagjEiKJE51q58r/FzueMg3iFmTRpdHQBDvihG9PzJbmMFtoSziVPKuRzYi0t2PRRB1mf2mpcR4JXKxtu9VoQtLL8HAuctb1VUQJQw7UMGazyTgzN7oQsOlmDP0dCfVQ1MK8BSQ9XL+eKGnqEtExkg/8DQWLeeTItZg+O9j9687kEEhPaVEaEhcGvjkoy9ZDvjLGJL6l7ofN20MA85klwLUFr3rTnlXGmdl8KpdTWHUftfdJ55qpLQ0SisaPPGJ2+F1NXYZGhZMRzUAIT0te7SKJf8A0S7iubFsXmDPJuCH78Ndip8W/CyA4SX9GtfpmV+kDeIlSfjjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xpyyry+WRuikWrAiPAU/rj/EEZVpKQYATgMnRA8+hLs=;
 b=itgQaOm9VCiRkw3/N5Tis6xwikcXRzWIfmgFhVsL7U57cOCBVQOexg9Deq80K9EosEaKGkL04cNNOGo6hPHSO2V4VwtYZCZbM95BJwgeEwGTDyMOz2bmMMfHWltxlp12q5O4OyC58mrLLxFvzl5mCuQodYJxbVpLKC0EhO8On7o=
Authentication-Results: gmx.com; dkim=none (message not signed)
 header.d=none;gmx.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB5140.namprd10.prod.outlook.com (2603:10b6:208:320::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.25; Tue, 7 Sep
 2021 03:06:50 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%6]) with mapi id 15.20.4478.025; Tue, 7 Sep 2021
 03:06:50 +0000
Subject: Re: Next steps in recovery?
To:     Robert Wyrick <rob@wyrick.org>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
References: <CAA_aC9-ZAdGC15HY-Q0S-N2M1OukST5BjAk9=WsD+NArCkCFUA@mail.gmail.com>
 <3139b2df-438c-ba40-2565-1f760e6d1edb@gmx.com>
 <9c2afb5f-e854-d743-3849-727f527e877b@gmx.com>
 <CAA_aC99-C8xOf7EAvJAMk2ZkYSaN2vyK7YFMw06utQ0T+tsh9A@mail.gmail.com>
 <6e03129e-f8c8-a00b-2afe-97a82d06c11e@gmx.com>
 <CAA_aC98OWWQHT8vGMQcDMHmsCEVZ+Aw30SdMeqrAa=y1qrV72w@mail.gmail.com>
 <7f8fde51-f920-06be-fdad-0cf59816adca@gmx.com>
 <CAA_aC98-x6vKp53gbtw+Ds5gF+LH6yYn2vqK0TPLE4GduHjsEA@mail.gmail.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <dbf70317-43af-4c70-b5d8-22a993228065@oracle.com>
Date:   Tue, 7 Sep 2021 11:06:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <CAA_aC98-x6vKp53gbtw+Ds5gF+LH6yYn2vqK0TPLE4GduHjsEA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0231.apcprd06.prod.outlook.com
 (2603:1096:4:ac::15) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.109] (39.109.186.25) by SG2PR06CA0231.apcprd06.prod.outlook.com (2603:1096:4:ac::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend Transport; Tue, 7 Sep 2021 03:06:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe3deb21-ba45-4053-0116-08d971ac8994
X-MS-TrafficTypeDiagnostic: BLAPR10MB5140:
X-Microsoft-Antispam-PRVS: <BLAPR10MB5140557114D0F737455147E3E5D39@BLAPR10MB5140.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zH88xm6DPJwGVBFjNRp7VXY65tcGTbA0NbYM8nNUxdvZzbzm6RIH1CRe2Sx+5lpOjLn/1848xAY75kdK+KRJ9t2It82qDW6LD/JIRKObepGz1/9/mg/L1iQbCpv3YC+BTLYyc5L9X5DN4OXxoWPdbVhiN9TrtjVdCkU9rN3IwDYTUCHYLgOmdDMH+8QokcccmMIzlXa3+R19kpfqfuNibmGkFiLZiPH8wjbBOua0c8LBtg2saBHLFbOHwLF1rnl1nfHn+EWFlBlpPsZuoUikqv7R0LXoM2ssYg3TfLg54EZvjyWDVSEW7mYod2PJLv0JcEq+vh1mboVD27mUQqqd1FTQPbbnv3kGz9bn97E/dHAX0mKB+7oLcg0gio5D9PAIKE7cUN67WcTgE0qCySrhpM9SN0j7hZlaQdgPzc7diiVYwfEc29SFnEcKUO/P0BNP4jdBKBiMc7SlZXA40Bez9vK0sCtzFrCnanQpPrlEz3gBO5dc4WNcG8zXFusqUYqKKUJ48D38dyvkN1mC/qKGHZxTh3y2QVTp4+N/H20n7Nx17/sDAxHRXi0FpkTLFBXKPwxaSOo3ixILo0uDiyrF+Vm76ubZe7kZxjZj/McKMmYx9CpbAc/H1yJdJGWP3HaeuC+bAjO4Jm4Qc14N4Z6W9xpPhH9bgryVe2KCAY9MArvzK62CXFHs6LasRfUOj5BRIPL9FHSQuzuIvoutNZlf7qjnQ48jk5WrqCFg81TQIFs2zsMfKT3W1wWmSdrmYtVddUkboNcRrlpbWcM0fcQLofNWcF+TdgPbyPXXSp0HbAziqJfsB2U31lyGVT9qHqHL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(39860400002)(376002)(396003)(346002)(478600001)(186003)(31696002)(8936002)(26005)(6486002)(86362001)(956004)(3480700007)(31686004)(83380400001)(38100700002)(53546011)(6666004)(4326008)(2906002)(6916009)(16576012)(316002)(5660300002)(54906003)(66476007)(44832011)(36756003)(66556008)(66946007)(8676002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckVKK2FJenBnR3JqNkF4Q1pGcGk2VFNPeUJFaUtUTHN6dTk5VldLODIrQlZQ?=
 =?utf-8?B?SFFIam1pT0xRLzZlR3JIV0JlaHpUbkltcHczVng5Y2xLMFFzMGlrelJ4RStR?=
 =?utf-8?B?clVjTzlaK2M4QWxZT1dXa1E3TzdPSjFMWHNBMWRQN2RpYXl5RFVNNFFZRlRV?=
 =?utf-8?B?VFljYnpGaTR0c2EvNkp1TTBla2xlM2p3b3lzT1VBZks3QStNTWtmK2s4UGFv?=
 =?utf-8?B?WWM4c1N3emZSbDlwM1FWODNHYXlWNGFMVTUvc09ubWxjM2FxYjFkZWtUaUUr?=
 =?utf-8?B?L2NXay95UU9oTUo3SmlRS01WTHJPcXJ2TzN2NGR1SW91Y01pOHpieFc1UnpH?=
 =?utf-8?B?LzRyT2tGd1AxRWhwR0F3YW45WHFjcmtjOGxvRFg5MW9TNEc4cThXamhuNjBm?=
 =?utf-8?B?VWlSK2k2c1ZoNzlLalQxMUhlbWp3Z0xKSzVIVk00YnZLeG9ZSEY2OFRsamRI?=
 =?utf-8?B?NTV1OUY2cVYxTVlOdjFFWlJPNmRnVkt0OVVLK2pMNjBIYndVYXpKUHpsWXdV?=
 =?utf-8?B?Nzh2SHgyVXl2NE1FWG5VNVVrQ2Z4a0VVcGp0b3BzeThkVFJiZWQ2YTR2Z3pM?=
 =?utf-8?B?RG5nb3dkVmVkQXE4U2RMdWtURVJzRkhXRjBJdy9xZm5pcVpIS2htQ0xiMlZN?=
 =?utf-8?B?ZTV5Y0ZET3lSMG8wdlBlZ3NXMHBMRmFrM1MvSUQ3WkVOQ3c2bEtZYk44SkRo?=
 =?utf-8?B?ZkNodjY2N29ZOXI3ZFI3MzdEaDhvTHZCYTlPdG1aOGRrY0NINzNScW5iMDBq?=
 =?utf-8?B?MVJhMjZKVW5DVCtZR1RXcy94VlpsaGZ0YjhONEw0eXlsLytHeVVsVytOV2lV?=
 =?utf-8?B?VTJWTVo5YlFsbU04QUtIc0ZuVVF3ejFBcjkrMm5OMmlMcGhsSlNmWTBVUjFF?=
 =?utf-8?B?SWhPT1FVOGdqTWRvcGFyWDhxaG1CTjg2NUZhY05rQlJZSVhCVmtTNi9RWEZs?=
 =?utf-8?B?dU9ybWMxVXFVeEN4eUdwLytNaGZBZ0RoOXlFeHg0NXRFRksvV2ZENlYvQVpW?=
 =?utf-8?B?L2trVVlQRjRHd295Nk03b1c5b29nR00rUC9tRVZ6WGltMzFHNDQ3Ry8vc3p4?=
 =?utf-8?B?RXRleVg5aSs4WU5lVVI3MkFvdThESDU3V3dVWFBPWWlVNi9ZQVJoREVBdE0z?=
 =?utf-8?B?SVNOMnVlOWZ6UUpGV21Fb3FRSUU3S0RJZklLN1MxcjBTblVlQnpNSWZnU0xF?=
 =?utf-8?B?Q2tnd3dWZEtTLytGUnFjVzhhYVZZOHVUZkl5SHc1cG9VaUp4eFZULysxakFl?=
 =?utf-8?B?LzNsTVJUc2paMHArVlQwQjRlam5oVlduS2U1aGJ4eW9KbUpIOGdqYzUzSmlz?=
 =?utf-8?B?ejJXcjVqb3krTFMvd2xYWFo1WHZhMHFRS2d4YlQ1T2ZCNXhOdnpHdXpnNU0r?=
 =?utf-8?B?b0RRajkrcy9lcUJCL1ZaRmJaUFJBOXFJRHNEN1ZidW9XdUpGNlI3RTFBdk9y?=
 =?utf-8?B?QmZyK1VDTFJ5UUNoVURDWGF3Y2I0b3FHVXFDVXByb2pmU3doNnFkc2N2V2ZO?=
 =?utf-8?B?YU44TzhjaFEwRUtpeWRDOW1pU1NiTHhpQUFBQ2FZbHdyRlB3bDZRUnZPYXRT?=
 =?utf-8?B?VHVzYldudmQ4M3I3aUd0dThkbUVJcDhlWEY5UkxxdC9vb1ZUK2tRQTl4NXJM?=
 =?utf-8?B?NjhLWElpdW9Iak5jWTVtemNNMFZycVpBOGFPTzBRdXlnczhtNE9rdHcyTisr?=
 =?utf-8?B?b2VDZ1JBTUpYdnMzODNHSy9oMXY3Ukl0R1ZlR1RvSEFCRlRxeG9rK0sxTWl1?=
 =?utf-8?Q?zlLxxjJYECNKBQ8SEPZc6xsW7jC83mIsFnJ1QpC?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe3deb21-ba45-4053-0116-08d971ac8994
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2021 03:06:50.7252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rn8avKgcfcTHcTHwDGI67GfPZ25vJG1OxfobittSUcAwJwc/IUp8qA7TF5kxu6NgcVgAt88VWmAUfBBCW7Wm5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5140
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10099 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=0
 bulkscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2108310000
 definitions=main-2109070018
X-Proofpoint-GUID: J8cYgqnSyHi9mQdDNUSXA7ooCLwLFVYa
X-Proofpoint-ORIG-GUID: J8cYgqnSyHi9mQdDNUSXA7ooCLwLFVYa
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 07/09/2021 10:36, Robert Wyrick wrote:
> Trying to build latest btrfs-progs.  I'm seeing errors in the configure script.
> 
> $ cat /etc/os-release
> NAME="Linux Mint"
> VERSION="20.2 (Uma)"
> ID=linuxmint
> ID_LIKE=ubuntu
> PRETTY_NAME="Linux Mint 20.2"
> VERSION_ID="20.2"
> HOME_URL="https://www.linuxmint.com/"
> SUPPORT_URL="https://forums.linuxmint.com/"
> BUG_REPORT_URL="http://linuxmint-troubleshooting-guide.readthedocs.io/en/latest/"
> PRIVACY_POLICY_URL="https://www.linuxmint.com/"
> VERSION_CODENAME=uma
> UBUNTU_CODENAME=focal
> 
> $ uname -a
> Linux bigbox 5.11.0-27-generic #29~20.04.1-Ubuntu SMP Wed Aug 11
> 15:58:17 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
> 
> $ ./configure
> checking for gcc... gcc
> checking whether the C compiler works... yes
> checking for C compiler default output file name... a.out
> checking for suffix of executables...
> checking whether we are cross compiling... no
> checking for suffix of object files... o
> checking whether we are using the GNU C compiler... yes
> checking whether gcc accepts -g... yes
> checking for gcc option to accept ISO C89... none needed
> checking how to run the C preprocessor... gcc -E
> checking for grep that handles long lines and -e... /bin/grep
> checking for egrep... /bin/grep -E
> checking for ANSI C header files... yes
> checking for sys/types.h... yes
> checking for sys/stat.h... yes
> checking for stdlib.h... yes
> checking for string.h... yes
> checking for memory.h... yes
> checking for strings.h... yes
> checking for inttypes.h... yes
> checking for stdint.h... yes
> checking for unistd.h... yes
> checking minix/config.h usability... no
> checking minix/config.h presence... no
> checking for minix/config.h... no
> checking whether it is safe to define __EXTENSIONS__... yes
> checking for gcc... (cached) gcc
> checking whether we are using the GNU C compiler... (cached) yes
> checking whether gcc accepts -g... (cached) yes
> checking for gcc option to accept ISO C89... (cached) none needed
> checking whether C compiler accepts -std=gnu90... yes
> checking build system type... x86_64-pc-linux-gnu
> checking host system type... x86_64-pc-linux-gnu
> checking for an ANSI C-conforming const... yes
> checking for working volatile... yes
> checking whether byte ordering is bigendian... no
> checking for special C compiler options needed for large files... no
> checking for _FILE_OFFSET_BITS value needed for large files... no
> checking for a BSD-compatible install... /usr/bin/install -c
> checking whether ln -s works... yes
> checking for ar... ar
> checking for rm... /bin/rm
> checking for rmdir... /bin/rmdir
> checking for openat... yes
> checking for reallocarray... yes
> checking for clock_gettime... yes
> checking linux/perf_event.h usability... yes
> checking linux/perf_event.h presence... yes
> checking for linux/perf_event.h... yes
> checking linux/hw_breakpoint.h usability... yes
> checking linux/hw_breakpoint.h presence... yes
> checking for linux/hw_breakpoint.h... yes
> checking for pkg-config... /usr/bin/pkg-config
> checking pkg-config is at least version 0.9.0... yes
> checking execinfo.h usability... yes
> checking execinfo.h presence... yes
> checking for execinfo.h... yes
> checking for backtrace... yes
> checking for backtrace_symbols_fd... yes
> checking for xmlto... /usr/bin/xmlto
> checking for mv... /bin/mv
> checking for a sed that does not truncate output... /bin/sed
> checking for asciidoc... /usr/bin/asciidoc
> checking for asciidoctor... no
> checking for EXT2FS... yes
> checking for COM_ERR... yes
> checking for REISERFS... yes
> checking for FIEMAP_EXTENT_SHARED defined in linux/fiemap.h... yes
> checking for EXT4_EPOCH_MASK defined in ext2fs/ext2_fs.h... yes
> checking linux/blkzoned.h usability... yes
> checking linux/blkzoned.h presence... yes
> checking for linux/blkzoned.h... yes
> checking for struct blk_zone.capacity... no
> checking for BLKGETZONESZ defined in linux/blkzoned.h... yes

> configure: error: linux/blkzoned.h does not provide blk_zone.capacity


> 
> ---
> 
> Info on the file in question (linux/blkzoned.h):
> 
> $ dpkg -S /usr/include/linux/blkzoned.h
> linux-libc-dev:amd64: /usr/include/linux/blkzoned.h
> 
> $ dpkg -l linux-libc-dev
> Desired=Unknown/Install/Remove/Purge/Hold
> | Status=Not/Inst/Conf-files/Unpacked/halF-conf/Half-inst/trig-aWait/Trig-pend
> |/ Err?=(none)/Reinst-required (Status,Err: uppercase=bad)
> ||/ Name                 Version      Architecture Description
> +++-====================-============-============-====================================
> ii  linux-libc-dev:amd64 5.4.0-81.91  amd64        Linux Kernel
> Headers for development
> 
> 
> So it appears that linux-libc-dev is way out-dated compared to my
> kernel.  I don't know how to update it, though... there doesn't appear
> to be a newer version available.

You could disable the zoned.

   ./configure --disable-zoned





