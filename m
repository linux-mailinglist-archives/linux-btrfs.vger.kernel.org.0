Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2CD3203BA2
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jun 2020 17:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729565AbgFVP4S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Jun 2020 11:56:18 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:14274 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729095AbgFVP4R (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Jun 2020 11:56:17 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05MFsWbm004877;
        Mon, 22 Jun 2020 08:56:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=l7IdroAdsliQiKTc2wJm5QmH4p8f+EKJjb3GYb69cNU=;
 b=czCLmaJMZNDSyawFDZXGtskf42ANWlaepgq/bd4kz4B0GknCjH182Wq5lMBZzkXCKDwq
 5YHbP3rIzp0OQuLSCRyzE7t0sq4Ss9Cg+9H3AU8fCuMzU9G9/cxGletvmdvmplDpUS9q
 Q4cEkg3//hJsjzMPmqwejmueR4TAIsGWDP8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31sfykrty1-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 22 Jun 2020 08:56:14 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 22 Jun 2020 08:56:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gTZWCub6kqEmBxmOr/GBZ9lPqbgNbAja/egVAWLRi2bq4N04D6xHHUUup8r3tcR4AmGjm16g8GlrKjjAl+ktN9zoQaCYwpJTz1BxZhiBC2RdEfXLj0hT+WCJ28FdEiRf7Cds6Zchc7c8AsC6bd/a3QArCvZBXUbssaWbOwY/OOupqYstrbmtIBYcqCs+q/MtU5jHoCXmi44ovyRmbg2Kc3NC/QsSzMwq62sa6JNf56mhRH1w5ZlA2eWIocAWqfaT9Lz1iBOb9J0MA95Zi12N443n9+yNgC9fLt75eXlRgTIGWXSRpeLdEmk/oecv6DhO7n5rG2IGu0v3Jq4ZoAY04g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7IdroAdsliQiKTc2wJm5QmH4p8f+EKJjb3GYb69cNU=;
 b=NZDOfMbCTeGvjhuyaY8gQuVTmjXpgkWCKGT7r/Bt28WRZdQ53LTxKqFwULYZS6+/8vI1OEJlhd2UFka9A4zn4doYExfF2IV8Pk8HswZu/bPLNkRLTAuC6VJUL5LNUqd50+OyKaYNk8SztdC537Xz2i38EjyTfmNBwkhu/jdTblT9jj4uQECv+XG2X8IWgSKDcHMPMANLnzae7X0PMEgz+Xwq7IytZj3oJxOl9V1kTM2yYDu6mhCB7Y0KnVSoowDLAokkRGCKBaXhm94wKCaGrLKk+k5x5RdsraKQqjcszfhKKT/Fs2WIu2vYIZbdCcGjk2/tzcB3qMEDoSSdI8SCAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7IdroAdsliQiKTc2wJm5QmH4p8f+EKJjb3GYb69cNU=;
 b=ZC7+hlq1EK8y5TSrN7Ayt0F5CfRyWo6hXWkM1ffOSzzLhrE+dm2hqVMOZqNOvYbfYWVSxoyIEAt0+Ekmaklc5ho3jv7p+8hWVnguPkDsEFb6IqQRDLRo/z198Zy5YNE9Y2kDJs2JGMgmJhI7vu2n2DdsI2JXiL6x45XjecLXAKY=
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fb.com;
Received: from CH2PR15MB3608.namprd15.prod.outlook.com (2603:10b6:610:12::11)
 by CH2PR15MB3592.namprd15.prod.outlook.com (2603:10b6:610:6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Mon, 22 Jun
 2020 15:56:11 +0000
Received: from CH2PR15MB3608.namprd15.prod.outlook.com
 ([fe80::5800:a4ef:d5b3:4dd1]) by CH2PR15MB3608.namprd15.prod.outlook.com
 ([fe80::5800:a4ef:d5b3:4dd1%5]) with mapi id 15.20.3109.026; Mon, 22 Jun 2020
 15:56:11 +0000
From:   "Chris Mason" <clm@fb.com>
To:     David Sterba <dsterba@suse.cz>
CC:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: weekly fstrim (still) necessary?
Date:   Mon, 22 Jun 2020 11:56:09 -0400
X-Mailer: MailMate (1.13.1r5671)
Message-ID: <2E6403C5-072D-4E71-8501-6D90FB539C15@fb.com>
In-Reply-To: <20200622142319.GG27795@twin.jikos.cz>
References: <20200621054240.GA25387@tik.uni-stuttgart.de>
 <CAJCQCtSbCid6OzvjK9fxXZosS_PAk2Lr7=VTpNijuuZXmRVVEg@mail.gmail.com>
 <20200621235202.GA16871@tik.uni-stuttgart.de>
 <CAJCQCtQmrc5m=H6d6xZiGvuzRrxBhf=wgf8bAMXZ_4p8F3AJFw@mail.gmail.com>
 <20200622000611.GB16871@tik.uni-stuttgart.de>
 <CAJCQCtQ8GFAdg2HJY_HqDgW8WAp5L1GoLbKqUN2mZ7s_kS-8XA@mail.gmail.com>
 <20200622140234.GA4512@tik.uni-stuttgart.de>
 <20200622142319.GG27795@twin.jikos.cz>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR19CA0033.namprd19.prod.outlook.com
 (2603:10b6:208:178::46) To CH2PR15MB3608.namprd15.prod.outlook.com
 (2603:10b6:610:12::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [100.109.69.16] (2620:10d:c091:480::1:e912) by MN2PR19CA0033.namprd19.prod.outlook.com (2603:10b6:208:178::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Mon, 22 Jun 2020 15:56:11 +0000
X-Mailer: MailMate (1.13.1r5671)
X-Originating-IP: [2620:10d:c091:480::1:e912]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d48c4a68-2591-45d0-a23e-08d816c4c8e4
X-MS-TrafficTypeDiagnostic: CH2PR15MB3592:
X-Microsoft-Antispam-PRVS: <CH2PR15MB359268AE0914253D6F0A72B4D3970@CH2PR15MB3592.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 0442E569BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CmpWxfGDfZ9+REGSBzsVPWVo901QOfnoNo+BNkUy9LtlItefAl2KLL7LAY+DifgaCtfPiDzuns95FpGpt1Dgg47Hoa98nJ/Ww6ga5aMeeXhmxBrviQIz6uv3fvZpI8KwffXsT9Rw1nfWDXusNkbFCyk+yGxyRzQXsLpQYqxy5OXfFEfoRjh8XRDdWVm/kwVMISnZXHyr1EqsvRh6zkwd6iC2HyObi3niCY/nvjEEvHorA8UzkZOIqU5KP24ZTYP1ItkqeE1O6e+NprYdB78Y0KqwkQvCzRxyqLGt1APR9dZe7O0MzQk4faQb9rehhhu21MLVPDZ2oKCf0otWwD3mWa32YJd6EshTAA/Y/xPnp1OyF4MdKr67YE9Aw7r06+grA/IgxSdhk8qN+72d52mPcEprLQOAMyPp240/QOo3eg4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR15MB3608.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(346002)(136003)(396003)(376002)(39860400002)(186003)(16526019)(8676002)(6916009)(4326008)(2906002)(6486002)(33656002)(5660300002)(86362001)(4744005)(36756003)(83380400001)(8936002)(53546011)(2616005)(66556008)(478600001)(66476007)(52116002)(66946007)(956004)(316002)(78286006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: IMip9GWoe95OVluCOCKFVEDvzqkU8x9kJMUJo3M5CuV57Uu2zJVZTENvfOEhqR1tmHU/FRFNjcvNcYzjp3JIx1h8/ApJmLIlOZEkdlFg1LyyfIF0ql7AIoRMz4s91bd2lLoe6qKEyCJ3BoY2kwRLO5lPoYGDaOccYyOUEsSrkCioONzkPV0u/3PlikIAzX1B4wUf9Y6TQJ3toFsw3/V00NSQV7/mjqwNCqb4htnp6l5ZAFfBFfthJker/qqoSygU0mfqQS6ajAorMy0Q/vNiY0wWOlitWUwW0wExpDe4uQu6dmqXjL4Mmot1qjJtRjlYO7AduMc9XJXjjnNxFsob/0D9m2eKdS57CQ96L4k0YgdEQE7EPv8ZbAuUowW2GGwZUspiXSqMhqCX/djsSIarvyfd8PTZDx8+RhPfmgGYB65I9E1eL0XY9fwDyUYklq42qWfqEdbw1dN51c0/Fz/fZv15B5NGEpT4aVaQbMVuj761l4iqESdzmsH4buvhmN9/0nVAhFuxklbTBZBv67SH/g==
X-MS-Exchange-CrossTenant-Network-Message-Id: d48c4a68-2591-45d0-a23e-08d816c4c8e4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2020 15:56:11.6590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aKRNgQIgtxd/WPtpltpJ7xPvqdDbJGj0KtzZr/HmImoXX1lfqupaUDzGbnEYUvQJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR15MB3592
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-22_09:2020-06-22,2020-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 suspectscore=0 adultscore=6 cotscore=-2147483648 impostorscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 mlxscore=0
 phishscore=0 mlxlogscore=838 spamscore=0 bulkscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006220117
X-FB-Internal: deliver
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 22 Jun 2020, at 10:23, David Sterba wrote:

> On Mon, Jun 22, 2020 at 04:02:34PM +0200, Ulli Horlacher wrote:
>> On Sun 2020-06-21 (18:57), Chris Murphy wrote:
>>
>>>>> You need to check fstrim.timer, which in turn triggers 
>>>>> fstrim.service.
>>>>
>>>> root@fex:~# cat /lib/systemd/system/fstrim.timer
>>>>
>>>> root@fex:~# cat /lib/systemd/system/fstrim.service
>>
>>> I'm familiar with the contents of the files. Do you have a question?
>>
>>
>> You have deleted my question, it have asked:
>>
>> This means: an extra fstrim (via btrfsmaintenance script, etc) is
>> unnecessary?
>
> You need only one service, either from the fstrim or from
> btrfsmaintenance.

Dennis’s async discard features are working much better here than 
either periodic trims or the traditional mount -o discard.  I’d 
suggest moving to mount -o discard=async instead.

-chris
