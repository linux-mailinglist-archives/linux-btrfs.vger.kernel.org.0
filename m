Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16FBA7C96FB
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 Oct 2023 00:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjJNWK4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 14 Oct 2023 18:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjJNWKz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 14 Oct 2023 18:10:55 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2082.outbound.protection.outlook.com [40.107.6.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25C3C9
        for <linux-btrfs@vger.kernel.org>; Sat, 14 Oct 2023 15:10:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cW45VBmo7j47T+J2S/rgsDEvwkTHr4OIUMdoZXsunLGwAYifdhuZsHZooYcup/cPnakihDSRMhS3vg5AU4QikVvsdNHXXEydTNgFLfrrqpMvZxjAXKBLImsy3TIhK0eyZBDHSLVnM2GutvKskhWQ/dwESeR57BF99+wv/+cYD86dSAQNEYrQlt1l2t/YEbjnDmTpbxZEy00RhdPXqNG1Nh2l4MmJq9AAtqzp/orDPvpWqkF2yjaqv1S0f8/idfPS6FAPAMm8AlmROTXYTyib2Rex/zkGjdGMneCsIUA28puEnzlzc1CABpsS2s4FXCK/7owtxoWv5XevOlvAu5p53g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fu2UwayUI3OR4UTGBQEOKQZ/cD8xaE8kTNgAXcxqw8c=;
 b=RxCetHJqyAtaTAc9hwinXQPSOCbgLnIY/DVLHxL0nCVpJtRXxOt8y7je+6Cduj7rQ8ypD5+xnAPlcfeCdJ+O+fMB8DQjO7fni8yMv5oWukbyhVe5R3p3/rq4Yygn9ZGmTXL5ZX0XsOYeXg6M0rr9TG1ig4htOGglTlMgD8Mur77d5QvjDEL3Va0x6V5p2Y878UhNpIJ7GjiIw2F9XeoUaHHI/EIVD2oJNRceVQOGkQCy2EBZx+/AeEsZK0LTbxo1zQFunOU1XClXmPffud/2Z5Fnavi86gDwmFd/L3gHQUflyGxPFENTwQvNZdioWGzAMBVCdqZ5Q0z3UfxLUu3/mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fu2UwayUI3OR4UTGBQEOKQZ/cD8xaE8kTNgAXcxqw8c=;
 b=EY5rCl6KlpGt0mMRB/ZvvcRhTcLLDkzQ9+BUpDkJPf7MHgPIPKR1ruFnPfMcAVJINe3CkKjBem+54Qe+SKWsaYMWCMUNVB1VfRb4N8ZxrP6yb3FUBLI0Jh9r4DkN+tr1mlC3gQ629iPP2b/Ii/sTR7vxwVTZGdaZL9qXAusLlKf99wU0XuEhBmoICD6dRBeFgXbA/JmSdCSOdKpaHbPdVyKqSrOMruHUuYre55LI89Dq+tVSFS5GmEYZ3CDz/dnh0WWcw8FOzaY9eKJ4N3558XU6YFMM8Olj1+9ab7pDYJye9vcRLjw0tVE+2qfVgMBiv+9zD40tDMCX1GwlsAXteg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by VI1PR04MB10028.eurprd04.prod.outlook.com (2603:10a6:800:1db::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Sat, 14 Oct
 2023 22:10:50 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::bf90:3aaf:2ddd:20a5]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::bf90:3aaf:2ddd:20a5%6]) with mapi id 15.20.6886.034; Sat, 14 Oct 2023
 22:10:49 +0000
Message-ID: <460ece89-d29c-4895-ae88-35ceadf17b02@suse.com>
Date:   Sun, 15 Oct 2023 08:40:33 +1030
User-Agent: Mozilla Thunderbird
Subject: Re: Deleting large amounts of data causes system freeze due to OOM.
To:     Chris Murphy <lists@colorremedies.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        fdavidl073rnovn@tutanota.com
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <NeBMdyL--3-9@tutanota.com>
 <4b8a10e4-4df8-4d96-9c6f-fbbe85c64575@suse.com> <NeGkwyI--3-9@tutanota.com>
 <bb668050-7d43-467f-8648-8bc5f2c314f1@gmx.com> <NeKx2tK--3-9@tutanota.com>
 <NfJJCdh--3-9@tutanota.com> <4cb27e5b-2903-4079-8e72-d9db2f19ced7@gmx.com>
 <NfT7gZI--3-9@tutanota.com> <d6fb2fd0-8c59-449c-a342-84eb908de969@gmx.com>
 <Ngf8uVZ--7-9@tutanota.com> <7bcaeca0-641a-43e8-8ffb-1f729e5e327d@gmx.com>
 <7dd58d68-3daf-4dd5-b6b7-e3ee0e160f68@app.fastmail.com>
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJVBQkNOgemAAoJEMI9kfOh
 Jf6oapEH/3r/xcalNXMvyRODoprkDraOPbCnULLPNwwp4wLP0/nKXvAlhvRbDpyx1+Ht/3gW
 p+Klw+S9zBQemxu+6v5nX8zny8l7Q6nAM5InkLaD7U5OLRgJ0O1MNr/UTODIEVx3uzD2X6MR
 ECMigQxu9c3XKSELXVjTJYgRrEo8o2qb7xoInk4mlleji2rRrqBh1rS0pEexImWphJi+Xgp3
 dxRGHsNGEbJ5+9yK9Nc5r67EYG4bwm+06yVT8aQS58ZI22C/UeJpPwcsYrdABcisd7dddj4Q
 RhWiO4Iy5MTGUD7PdfIkQ40iRcQzVEL1BeidP8v8C4LVGmk4vD1wF6xTjQRKfXHOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJuBQkNOge/AAoJEMI9kfOhJf6o
 rq8H/3LJmWxL6KO2y/BgOMYDZaFWE3TtdrlIEG8YIDJzIYbNIyQ4lw61RR+0P4APKstsu5VJ
 9E3WR7vfxSiOmHCRIWPi32xwbkD5TwaA5m2uVg6xjb5wbdHm+OhdSBcw/fsg19aHQpsmh1/Q
 bjzGi56yfTxxt9R2WmFIxe6MIDzLlNw3JG42/ark2LOXywqFRnOHgFqxygoMKEG7OcGy5wJM
 AavA+Abj+6XoedYTwOKkwq+RX2hvXElLZbhYlE+npB1WsFYn1wJ22lHoZsuJCLba5lehI+//
 ShSsZT5Tlfgi92e9P7y+I/OzMvnBezAll+p/Ly2YczznKM5tV0gboCWeusM=
In-Reply-To: <7dd58d68-3daf-4dd5-b6b7-e3ee0e160f68@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MEAPR01CA0063.ausprd01.prod.outlook.com
 (2603:10c6:201:30::27) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|VI1PR04MB10028:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e54ce28-6cf9-4bd9-32cc-08dbcd026c04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rOBV7Mk2hlkcSdO6C2xs7Kg4ST2UPAtqTRHsi6aRDtlvoKMrI89O1uwr9dQIkVW41NAEE/0RBGnrTXymjovSHaIU/RdX6fEpeayHhMuYWknrx7+eIuNRVZsKdNRernNzz+2B1wxJiIgo70te/zmeQJFLedHLE2tLrQaREZmmd+hJg3xtahHVzfN8zQ0J5vsigvSJobm7DpNHcHcf8U1bCNAGMM1uPWJ+Et8Gbh7lBqMdcapCGRidQ1TBwEvBqFAyI++jPGV6aJeutgaTSGvHuxIFjvqSMyxR8Hcvjwlwq1/UusN3Bk5aGSwTG0bAdEDP7V4sGylYNgnhBypFk09ldb3kr+57uk34ePd4idpFFex1efqnp2hQmgZvT+q0x84Q88dbk/GygZ5x3MO8pY93JezMDgi3v23271ug+zBOgE7f4OrEpVLt8HFZQ7eFq8WMpt+Ib/huKZQtFfgFZdaGPK2w40TvoRAtXHsnLgPQ5xbqZ4RMymV1m9XJGtj92Z6j5JsOfex50yVzQlm8xwL3OTFcGsHwc6ukfuGJZDkn75/d0XimMdAVhBhxBDq3EmjVnSpMfZLsBpt72zDpTFzLQQuht1UrdhrMGb/zcRe8JR5cPXK2pcLDtyykfm6SxN3TYMc01JOINsK5PYBOu3n71A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(366004)(136003)(39850400004)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(6512007)(38100700002)(26005)(2616005)(478600001)(6486002)(5660300002)(8676002)(8936002)(4326008)(86362001)(31696002)(2906002)(316002)(36756003)(41300700001)(66476007)(66556008)(66946007)(110136005)(6666004)(53546011)(6506007)(31686004)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MG1UVlppK0kzeFhwUEZ0dHBYTkQ4NTRtdVdnbTVHSzNYbTRkTFdLckw1bmtD?=
 =?utf-8?B?TzZ3ZkRVK0pxV05hYmZTWnhlSDJrSUpNbUF3WkVNYy93S3NDU2Y5b0R6WmNJ?=
 =?utf-8?B?Q0RXVTI2SVV1QWRQckVIMDlTVk80eGlkaTczSmdxSkdyei9aaXN3d0t3Y0h1?=
 =?utf-8?B?ZWJDYzVFQWwxcHFSQi9iSFNzZ2REc0l0UVByVFA3Q01IeWNzaVd6NVBFeVdr?=
 =?utf-8?B?RlVlQTFpVFlHd3JMWjlzVGF5alYvRzkyNHBoc3lxeWRadHp4ejUzWWg1M2Fo?=
 =?utf-8?B?ZEFRS1E1akNpUjB4d3Zwa2NhcEZnK3grOG1uZGVKQ3c3eXdxTS9NQTZvVnlW?=
 =?utf-8?B?R0xzbklJUEhrelRWYVJnRHVmSDdNWXZPdkRSR1h5aEJKNEpqQitkU29KTHpB?=
 =?utf-8?B?WjFZZE9IZ2t2YVNVYWZOTFBuQzB4NEtCcm5VU2tkblUrKzh3WnVVbFpWYjd3?=
 =?utf-8?B?bUQ5TDJSOGo5SnBTbmNtNklvTTNydnBNL3dCVnJ2S29lUVRjc0VJRm9iaXdO?=
 =?utf-8?B?YjRtVlV6RGlNT2orTW9CQzRsNDhOLzZKMFMyNXpKTm5zREhTd0k5djN6RjV0?=
 =?utf-8?B?VTF2YlhyUUxJOStCbHNjRXhlU3ZNVEtNcVhCUHM0TEd0eFJzVGdIaGwvOGRQ?=
 =?utf-8?B?cjh3bTZ4bVJOY1VSWm5PRU1rOThOVko0QXoyR2UxRzRQQjBQR3RFQzFmUm43?=
 =?utf-8?B?Rk1YMXB5SmpvWkMrdFVpcUNnTkxLTDFlL1JxcUV3MXlMOFVMOUFYWk9raDNI?=
 =?utf-8?B?Y29wWE83cmJWUThJWDRSS1NoOHB4bFJzYytBcUpNaW9ERnh2SEtsbFUyY2xm?=
 =?utf-8?B?aExpZHVHejJnVE1qb3dBS2U1R3FWbnRIWU5SR25QZWFhMlhvcVJjckxBZE9n?=
 =?utf-8?B?YmIvcmZqNUFrN2kwei8xb0lDWk53NHkwMHNTSWZCZHJZUWs1M2pHeFpDNmVB?=
 =?utf-8?B?RkpVVncvU1AwWnQ3cVRnK25BOHF4azNsTVZUWXJ2NVpUSG9kQUFsSStqRmZC?=
 =?utf-8?B?QjNJVUVvUERmb25TMlUrcVZKQmFhdXdyWXp2VUR3ZlBlSERsNksrbEdNY2Vt?=
 =?utf-8?B?UGdQYzl0ZE9LdVgwckZTelFUUDZQWjU3aHNKMSsvZWV1bnBHYWszVUZmMTVP?=
 =?utf-8?B?ZFRPeFdkdXA5cHRESW1wNkYrOUFyancxOFJWZCtBUWZEUTEzdmVMMUhHSi93?=
 =?utf-8?B?ZHJJWm5vdHMrU3hwOGpMREVuR05POGtNdXl1ak1HTnU1WTEzektmNWEzVFZJ?=
 =?utf-8?B?WW5HRURVc2Nwb0pCbzZkSjBLQ2d5S3Y2QkpLMzFJNWJTaXpKSm5aeTZ5cWtY?=
 =?utf-8?B?RU85dEhOR0V3dmwyS0pNWU9ORnlMdStmM3E3S0xmYml1S04ySVhxQlFmT1do?=
 =?utf-8?B?bGxTQzFrbFdiRExpNk93Q2M2Nkl4U1B5bXlyem9sRzljdGhaRU1uT1dYRFV5?=
 =?utf-8?B?YmsrZ0N4RXFmY3M4VThEcTRmNXh1NENicVVIK21OaHMzTjRtQ01uVW9XYjVC?=
 =?utf-8?B?QUVyZU4wZ2NpUTFTMk1FQ1hEZlg1OUs1MmEweW5vbTMyUHhUSERzOWl2OWd6?=
 =?utf-8?B?bHM0clVjRzA5VERqd3JCQ3djVGFUMGRvYnVoYm15aG44dmJINmN2clJvQVJ4?=
 =?utf-8?B?QWwxYk00SnE3aFZkS3VBenh4TXY1WFk0NkxZd2JBQ1NrVmFNWHcrdml1SXda?=
 =?utf-8?B?WHVYS2xhWnp3N0N4V2laL3ptQXlxRjU4OVgyMnRRTVVKTmJKd21Lay9lRUkr?=
 =?utf-8?B?SHZvYXg0cWZUSGNuUzRVaWQ4WHBMc3F1Q2JKNHRhSU1zclRMYmtHK3IvL0s1?=
 =?utf-8?B?VjBGc1FsdUNXY21DdWRkckVDQS84a1pCTTZ0d2crZWIzODlYdjlSbjhNOTg5?=
 =?utf-8?B?aE0wL0o3d0hDZU1aR0w2MGt6UTVKZEJUM1MyS21lQVVvV0NCNit0SHdCQmFP?=
 =?utf-8?B?YWR1ckZzeUsvdWlxdzVRUU9VZjc1ZFVMQTE4c09aTDROSlZIQldHRDE4bjBl?=
 =?utf-8?B?V3VVbUxCTDhicDJQTUZ3Zk16dUtJaExseHFKRWJFQlV0Z2FjVjM4ZklLUm1T?=
 =?utf-8?B?cnNBQXBpaHRIUU1iKzNUdkFlK2lIK0ZhOURuWnlxWGw5Z3pxc0JtSHgyS1c5?=
 =?utf-8?Q?JKfc=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e54ce28-6cf9-4bd9-32cc-08dbcd026c04
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2023 22:10:49.6713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3l4zGxVs9EI8Uro9QE/Oa7flWjd7plLWwb/91lGVZVZvnJCvYAZDfxx6kXk0rUZA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10028
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/10/15 05:39, Chris Murphy wrote:
> 
> 
> On Fri, Oct 13, 2023, at 6:32 PM, Qu Wenruo wrote:
>> On 2023/10/14 08:58, fdavidl073rnovn@tutanota.com wrote:
> 
>>> Is there anything else I can do to make sure this is addressed at some point? I would like to eventually be able to re-enable compression as it was saving me several terabytes.
>>
>> I believe Filipe is working on improving the extent map code recently.
>> You may want to test his patchset when it comes out.
>>
>> Otherwise you may need to keep away from compression for now.
> 
> Is the cost of tracking extents reduced at all by increasing leaf/node size?

Unfortunately no.

The cost is related to the size of extent_map structure, which is 
independent from node/leaf size.


> The number of extents is the same, so that cost wouldn't be reduced - and maybe that's the bulk of the problem. But if it's also related to the cost of having so many leaves, maybe it would help?

For metadata, they are cached using inode's address space, thus MM layer 
is able to properly drop the unused space AFAIK.

Meanwhile we have no way to free unused extent_map for now.

Thanks,
Qu
